package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

createManufacturingOrderOutput: {
	Name: "createManufacturingOrderOutput"
	Fields: [
		{Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
	]
}

createManufacturingOrderAndWorkOrders: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createManufacturingOrderAndWorkOrders"
	Description:  """
		The purpose of this Pipeline is to create a Manufacturing Order (MO), associated Work Orders (WO) and associate mo line items.
		Steps:
		1. Fetch the Bill of Materials (BOM) operations for the given BOM ID.
		2. Validate the existence of operations. If no operations are found, throw an error.
		3. Create the Manufacturing Order (MO) using the fetched BOM details.
		4. Iterate through the operations to create corresponding Work Orders (WO).
		5. Create mo line items corresponding to bom lineitems.
		6. Retrieve all dependent operations and associated work orders for linking with the created work order.
		7. Add work order dependencies by mapping operations to their corresponding dependent work orders .
		"""
	Response: {Type: createManufacturingOrderOutput}
	PostScript: """
		{
			"manufacturingOrderId": get(context.pipeline.createMo.manufacturingOrderId),
		}
	"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "createManufacturingInput"
				Fields: [
					{Name: "bomId", Type: pipeline.ID, Required: true},
					{Name: "quantity", Type: pipeline.Int, Required: true},
					{Name: "name", Type: pipeline.String, Required: true},
					{Name: "parentMoId", Type: pipeline.ID},
					{Name: "parentMoItem", Type: pipeline.ID},
					{Name: "moBatchId", Type: pipeline.ID},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "fetchBomOperations"
			Description: "Fetches all active operations and line items associated with a specific Bill of Materials (BOM). It also calculates the total duration for each operation and the required quantity and total cost for each line item based on the provided quantity.",
			PreScript: """
					{
						'bomId': context.args.input.bomId
					}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
						query fetchBomOperations($bomId: ID!) {

							bom(id: $bomId) {
								id
								itemId
							}
							operations(
								query: {bomId: {eq:$bomId}, isActive: {eq: true}}
							) {
								collection {
									id
									duration
									documentUrl
									description
									order
									name
									isActive
									workCenterId
									workCenter {
										name
										timeEfficiency
										parallelProcessingLimit
										setupTime
										cleanupTime
									}
								}
							}
							bomLineItems(
								query: {bomId: {eq:$bomId}}
							) {
								collection {
									id
									unitCost
									inputQuantity
									scrapAction
									returnAsNewSkuItemId
								}
							}
							operationLineItems(query: {bomId: {eq:$bomId}}) {
								collection {
									id
									bomLineItemId
									operationId
									quantity
									scrapAction
									returnAsNewSkuItemId
								}
							}
						}"""
			}
			PostHook: common.#Script & {
				Expr: """
					(() => {
						const outputQuantity = context.args.input.quantity;
						const calculatedOperations = args.operations.collection.length == 0 ? [] : args.operations.collection.map(e=> ({
							"id": e.id,
							"order": e.order,
							"calculatedDuration": Math.floor(e.workCenter.setupTime + e.workCenter.cleanupTime + ((Math.floor(outputQuantity / e.workCenter.parallelProcessingLimit) + (outputQuantity % e.workCenter.parallelProcessingLimit)) * e.duration * 100 / (e.workCenter.timeEfficiency * 100)))
						}));
						const calculatedLineItems = args.bomLineItems.collection.length== 0 ? [] : args.bomLineItems.collection.map(e => ({
							"id": e.id,
							"scrapAction": e.scrapAction,
							"returnAsNewSkuItemId": e.returnAsNewSkuItemId,
							"requiredQuantity": context.args.input.quantity * e.inputQuantity,
							"totalCost": context.args.input.quantity * e.inputQuantity * e.unitCost,
						}));

						return {
							"bom": args.bom,
							"operationLineItems": args.operationLineItems.collection,
							"quantity":context.args.input.quantity,
							calculatedOperations,
							calculatedLineItems
						}
					})()
				"""
			}
			PostValidation: """
				// Check if the BOM is null
				isNull(context.pipeline.fetchBomOperations.bom) ?
				['No BOM found for the given BOM ID: ', context.args.input.bomId].join('') :
				// Check if there are no calculated operations
				size(context.pipeline.fetchBomOperations.calculatedOperations) == 0 ?
				['No operations found for the BOM ID: ', context.args.input.bomId].join('') :
				// Check if there are no line items
				size(context.pipeline.fetchBomOperations.calculatedLineItems) == 0 ?
				['No line items found for the BOM ID: ', context.args.input.bomId].join('') :
				// No issues found, return an empty string
				''
			"""
		},
		{
			Name:        "createMo"
  			Description: "Creates a Manufacturing Order based on the provided inputs and associated BOM operations. It initializes the order with the specified quantity, scheduled date, and other details.",
			Test: "isNull(context.pipeline.fetchBomOperations.bom) ? false : size(context.pipeline.fetchBomOperations.calculatedOperations) == 0 ? false : size(context.pipeline.fetchBomOperations.calculatedLineItems) == 0 ? false : true"
			PreScript:   """
				{
					'input': {
						'bomId': context.pipeline.fetchBomOperations.bom.id,
						'itemId': context.pipeline.fetchBomOperations.bom.itemId,
						'name': get(context.args.input.name),
						'quantity': get(context.args.input.quantity),
						'parentMoId': get(context.args.input.parentMoId),
						'moBatchId': get(context.args.input.moBatchId),
					}
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation createMo (
						$input: ManufacturingOrderCreateInput!
					) {
						createManufacturingOrder(input: $input) {
							id
						}
					}
				"""
			}
			PostScript: """
					{
						"manufacturingOrderId": args.createManufacturingOrder.id,
						"results":context.pipeline.fetchBomOperations.calculatedOperations
					}"""
		},
		{
			Name:        "createWorkOrders"
			Description: "Creates multiple work orders by bulk inserting them based on the calculated operations from the associated Manufacturing Order"
			Test: 		 "size(context.pipeline.fetchBomOperations.calculatedOperations) > 0"
			PreScript: """
			{
					"input": size(context.pipeline.fetchBomOperations.calculatedOperations)== 0 ? [] : context.pipeline.fetchBomOperations.calculatedOperations.map(e, {
							'operationId': e.id,
							'moId': get(context.pipeline.createMo.manufacturingOrderId),
							'expectedDuration': e.calculatedDuration,
							'order': e.order,
					}),

			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation createWO (
						$input: [WorkOrderCreateInput]
					) {
						bulkUpsertWorkOrders(input: $input)
					}
				"""
			}
		},
		{
			Name:        "createMOLineItems"
			Description: "Creates multiple manufacturing order line items by bulk inserting them based on the calculated line items associated with the Manufacturing Order"
			Test: 		 "size(context.pipeline.fetchBomOperations.calculatedLineItems) > 0"
			PreScript: """
			{
					"input": size(context.pipeline.fetchBomOperations.calculatedLineItems)== 0 ? [] : context.pipeline.fetchBomOperations.calculatedLineItems.map(e, {
							'bomLineItemId': e.id,
							'moId': get(context.pipeline.createMo.manufacturingOrderId),
							'totalCost': e.totalCost,
							'requiredQuantity': e.requiredQuantity,
					}),

			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation createMOLineItems (
						$input:  [MOLineItemCreateInput]
					) {
						bulkUpsertMOLineItems(input: $input)
					}
				"""
			}
		},
		{
			Name:        "updateMoLineitem"
			Description: "Updates a manufacturing order line item if it is associated with nested BOM line items"
			Test:        "!isNull(context.args.input.parentMoItem)"
			PreScript: """
			{
					"input":{
						'itemMoId': get(context.pipeline.createMo.manufacturingOrderId)
					},
					"id":context.args.input.parentMoItem
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation updateMoLineitem (
						$id:ID!,
						$input:  MOLineItemUpdateInput!
					) {
						updateMOLineItem(id:$id,input: $input){
							id
						}
					}
				"""
			}
		},
		{
			Name:        "getAllDependentOperationAndWorkOrders"
			Description: "Retrieve all dependent operations and associated work orders for linking with the created work order."
			Test: 		 "size(context.pipeline.fetchBomOperations.calculatedOperations) > 0"
			PreScript: """
			{
					"operationId": size(context.pipeline.fetchBomOperations.calculatedOperations)== 0 ? [] : context.pipeline.fetchBomOperations.calculatedOperations.map(e, e.id),
					"moId": get(context.pipeline.createMo.manufacturingOrderId),
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query getAllDependentOperationAndWorkOrders($operationId:[ID],$moId:ID!) {
					operationDependencies(query: {operationId: {in: $operationId}}) {
						collection {
						dependsOnOperationId
						operationId
						id
						}
					}
					workOrders(query: {moId: {eq: $moId}, isDeleted: {eq: false}}) {
						collection {
							id
							moId
							operationId
						}
					}
					mOLineItems(query: {moId: {eq: $moId}, isDeleted: {eq: false}}) {
						collection {
							id
							requiredQuantity
							moId
							itemMoId
							bomLineItemId
							totalCost
						}
					}
				}
				"""
			}
		},
		{
			Name:        "addDependentWorkOrder"
			Description: "Add work order dependencies by mapping operations to their corresponding dependent work orders"
			Test: 		 "size(context.pipeline.fetchBomOperations.calculatedOperations) > 0"
			PreHook: common.#Script & {
				Expr: """
				(() => {
					const dependencyArray = context.pipeline.getAllDependentOperationAndWorkOrders.operationDependencies.collection;
					const workOrderArray = context.pipeline.getAllDependentOperationAndWorkOrders.workOrders.collection;

					const resultArray = dependencyArray.map(dependency => {
						// Find workOrderId (matching operationId from workOrderArray)
						const workOrder = workOrderArray.find(source => source.operationId === dependency.operationId);

						// Find dependsOnworkOrderId (matching dependsOnOperationId from workOrderArray)
						const dependsOnWorkOrder = workOrderArray.find(source => source.operationId === dependency.dependsOnOperationId);

						return {
							workOrderId: workOrder ? workOrder.id : null,
							dependsOnWorkOrderId: dependsOnWorkOrder ? dependsOnWorkOrder.id : null
						};
					})
						.filter(e => e.workOrderId && e.dependsOnWorkOrderId);

					return {
						'input': resultArray
					};
				})()
				"""
			}
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation addDependentWorkOrder (
						$input: [WorkOrderDependencyCreateInput]
					) {
						bulkUpsertWorkOrderDependencies(input: $input)
					}
				"""
			}
		},
		{
			Name:        "addWorkOrderLineItem"
			Description: "Add work order line item by mapping operations and lineitems"
			Test: 		 "size(context.pipeline.fetchBomOperations.operationLineItems) > 0"
			PreHook: common.#Script & {
				Expr: """
				(() => {
					const operationLineItems = context.pipeline.fetchBomOperations.operationLineItems;
					const mOLineItems = context.pipeline.getAllDependentOperationAndWorkOrders.mOLineItems.collection;
					const workOrders = context.pipeline.getAllDependentOperationAndWorkOrders.workOrders.collection;
					
					const result = operationLineItems.map(operationLineItem => {
						const bomLineItemId = operationLineItem.bomLineItemId;

						// Find the matching moLineItem by bomLineItemId
						const moLineItem = mOLineItems.find(item => item.bomLineItemId === bomLineItemId);
						const moLineItemId = moLineItem ? moLineItem.id : null;

						const operationId = operationLineItem.operationId;

						// Find the matching workOrder by operationId
						const workOrder = workOrders.find(wo => wo.operationId === operationId);
						const workOrderId = workOrder ? workOrder.id : null;

						return {
							'moLineItemId': moLineItemId,
							'moId':context.pipeline.createMo.manufacturingOrderId,
							'returnAsNewSkuItemId': operationLineItem.returnAsNewSkuItemId,  
							'scrapAction': operationLineItem.scrapAction,
							'quantity': operationLineItem.quantity,
							'workOrderId': workOrderId
						};
					});
					
					return {
						'input': result
					};
				})()
				"""
			}
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation addWorkOrderLineItem (
						$input:  [WorkOrderLineItemCreateInput]
					) {
						bulkUpsertWorkOrderLineItems(input: $input)
					}
				"""
			}
		},
	]
}
