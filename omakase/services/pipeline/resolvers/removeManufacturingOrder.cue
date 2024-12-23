package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

removeManufacturingOrderOutput: {
	Name: "removeManufacturingOrderOutput"
	Fields: [
		{Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
		{Name: "success", Type: pipeline.Boolean, Required: true},
	]
}

removeManufacturingOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "removeManufacturingOrder"
	Description: """
		The purpose of this operation is to cancel a Manufacturing Order (MO) and its associated components. The steps involved are as follows:
		
		1. Fetch all Work Orders and associated MO Line Items for the specified MO, validate their presence, and return detailed information.
		2. Mark Work Orders as deleted by retrieving existing Work Orders, updating their status to deleted, and performing a bulk update to apply the changes.
		3. Mark MO Line Items as deleted by retrieving existing MO Line Items, flagging them as deleted, and performing a bulk update to apply the changes.
		4. Mark the specified MO as deleted by setting the `isDeleted` flag to true and confirming the successful cancellation.
	"""
	Response: {Type: removeManufacturingOrderOutput}
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "removeManufacturingOrderInput"
				Fields: [
					{Name: "moId", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "fetchWorkOrders"
			Description: "Fetches all Work Orders and associated Manufacturing Order Line Items for a given Manufacturing Order (MO). Validates the presence of Work Orders and returns detailed information on both Work Orders and MO Line Items."
			PreScript: """
					{
						'moId': context.args.input.moId
					}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
						query fetchWorkOrders($moId: ID!) {

							manufacturingOrder(id: $moId) {
								id
								isDeleted
								name
							}

							workOrders(query: { moId: {eq: $moId}}) {
								edges {
      								node {
										id
										expectedDuration
										endDate
										moId
										operationId
										realDuration
										startDate
										status
									}
								}
							}

							mOLineItems(query: {moId: {eq: $moId}}) {
								edges {
      								node {
										id
										moId
										bomLineItemId
										itemMoId
										totalCost
										requiredQuantity
									}
								}
							}
							workOrderLineItems(query: {moId: {eq: $moId}}) {
								edges {
      								node {
										moId
										moLineItemId
										quantity
										scrapAction
										returnAsNewSkuItemId
										workOrderId
										id
									}
								}
							}				
						}"""
			}
			PostScript: """
					{
						"manufacturingOrder": args.manufacturingOrder,
						"workOrders": args.workOrders,
						"mOLineItems": args.mOLineItems,
						"workOrderLineItems": args.workOrderLineItems,
					}"""
			PostValidation: """
				isNull(context.pipeline.fetchWorkOrders.manufacturingOrder) ?
				['No manufacturing order found for the given ID: ', context.args.input.moId].join('') :
				''
				"""
		},
		{
			Name:        "markWorkOrderDeleted"
			Description: "Marks Work Orders as deleted by updating their status in the system. This operation retrieves existing Work Orders, sets them as deleted, and then performs a bulk update to apply the changes."
			Test: 		 "size(context.pipeline.fetchWorkOrders.workOrders.edges) > 0"
			PreScript:   """
				{
					"input": size(context.pipeline.fetchWorkOrders.workOrders.edges)== 0 ? [] : context.pipeline.fetchWorkOrders.workOrders.edges.map(e, {
							'id': e.node.id,
							'isDeleted':true,
							'expectedDuration': e.node.expectedDuration,
							'endDate': e.node.endDate,
							'moId': e.node.moId,
							'operationId': e.node.operationId,
							'realDuration': e.node.realDuration,
							'startDate': e.node.startDate,
							'status': e.node.status,
					}),
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation markWorkOrderDeleted (
						$input: [WorkOrderCreateInput]
					) {
						bulkUpsertWorkOrders(input: $input)
					}
				"""
			}
		},
		{
			Name:        "markMoLineItemDeleted"
			Description: "Marks Manufacturing Order (MO) Line Items as deleted by updating their status in the system. This operation retrieves the existing MO Line Items, flags them as deleted, and then performs a bulk update to apply the changes."
			Test: 		 "size(context.pipeline.fetchWorkOrders.mOLineItems.edges) > 0"
			PreScript:   """
				{
					"input": size(context.pipeline.fetchWorkOrders.mOLineItems.edges)== 0 ? [] : context.pipeline.fetchWorkOrders.mOLineItems.edges.map(e, {
							'id': e.node.id,
							'isDeleted':true,
							'moId': e.node.moId,
							'bomLineItemId': e.node.bomLineItemId,
							'itemMoId': e.node.itemMoId,
							'totalCost': e.node.totalCost,
							'requiredQuantity': e.node.requiredQuantity,
					}),
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation markMOLineItemDeleted (
						$input: [MOLineItemCreateInput]
					) {
						bulkUpsertMOLineItems(input: $input)
					}
				"""
			}
		},
		{
			Name:        "workOrderLineItemDeleted"
			Description: "Marks Manufacturing Order (MO) work order Line Items as deleted by updating their status in the system. This operation retrieves the existing work order Line Items, flags them as deleted, and then performs a bulk update to apply the changes."
			Test: 		 "size(context.pipeline.fetchWorkOrders.workOrderLineItems.edges) > 0"
			PreScript:   """
				{
					"input": size(context.pipeline.fetchWorkOrders.workOrderLineItems.edges)== 0 ? [] : context.pipeline.fetchWorkOrders.workOrderLineItems.edges.map(e, {
							'id': e.node.id,
							'isDeleted':true,
							'moId': e.node.moId,
							'moLineItemId': e.node.moLineItemId,
							'quantity': e.node.quantity,
							'scrapAction': e.node.scrapAction,
							'returnAsNewSkuItemId': e.node.returnAsNewSkuItemId,
							'workOrderId': e.node.workOrderId,
					}),
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation workOrderLineItemDeleted (
						$input: [WorkOrderLineItemCreateInput]
					) {
						bulkUpsertWorkOrderLineItems(input: $input)
					}
				"""
			}
		},
		{
			Name:        "markMODeleted"
			Description: "Marks a Manufacturing Order (MO) as deleted by updating its status in the system. This operation sets the `isDeleted` flag to true for the specified MO and confirms the successful deletion."
			PreScript: """
			{
					'id': context.args.input.moId,
					'input': {
						'isDeleted':true
					}
				}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation markMODeleted (
						$input: ManufacturingOrderUpdateInput!,
						$id:ID!
					) {
						updateManufacturingOrder(id: $id,input: $input) {
							id
						}
					}
				"""
			}
			PostScript: """
					{
						"manufacturingOrderId": context.args.input.moId,
						"success": true,
					}"""
		},
		
	]
}
