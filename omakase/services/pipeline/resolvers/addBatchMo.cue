package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

addBatchMoOutput: {
	Name: "addBatchMoOutput"
	Fields: [
		{Name: "batchManufacturingOrderId", Type: pipeline.ID, Required: true},
	]
}

addBatchMo: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "addBatchMo"
	Description:  """
		The purpose of this Pipeline is to create a Manufacturing Order (MO), associated Work Orders (WO) and associate mo line items.
		Steps:
		1. Fetch the Bill of Materials (BOM) operations for the given BOM ID.
		2. Validate the existence of operations. If no operations are found, throw an error.
		3. Create the Batch Manufacturing Order (MO) using the fetched BOM details.
		4. Preview Batch Manufacturing Order (MO) using the fetched BOM details.
		5. Create Manufacturing Orders.
		"""
	Response: {Type: addBatchMoOutput}
	PostScript: """
		{
			"batchManufacturingOrderId": get(context.pipeline.createMOBatch.moBatchId),
		}
	"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "addBatchMoInput"
				Fields: [
					{Name: "bomId", Type: pipeline.ID, Required: true},
					{Name: "quantity", Type: pipeline.Int, Required: true},
					{Name: "batchSize", Type: pipeline.Int, Required: true},
					{Name: "name", Type: pipeline.String, Required: true},
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
							"requiredQuantity": context.args.input.quantity * e.inputQuantity,
							"totalCost": context.args.input.quantity * e.inputQuantity * e.unitCost,
						}));

						return {
							"bom": args.bom,
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
            Name:        "createMOBatch",
            Description: "Creates a Manufacturing Order Batch with the given input.",
            PreScript: """
            {
                "input": {
                    "bomId": context.args.input.bomId,
                    "itemId": context.pipeline.fetchBomOperations.bom.itemId,
                    "quantity": context.args.input.quantity,
                    "batchSize": context.args.input.batchSize,
                    "name": context.args.input.name
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation createMOBatch($input: MOBatchCreateInput!) {
                    createMOBatch(input: $input) {
                        id
                    }
                }
                """
            },
            PostScript: """
            {
                "moBatchId": args.createMOBatch.id
            }
            """,
        },
		{
            Name:        "previewMoBatch",
            Description: "Generates the batches using 'previewMoBatch'.",
            PreScript: """
            {
                "bomId": context.args.input.bomId,
                "batchSize": context.args.input.batchSize,
                "totalQuantity": context.args.input.quantity,
                "name": context.args.input.name
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
					query previewMoBatch($bomId: ID!, $batchSize: Int!, $totalQuantity: Int!, $name: String!) {
						previewMoBatch(bomId: $bomId, batchSize: $batchSize, totalQuantity: $totalQuantity, name: $name) {
							moBatches {
								bomId
								name
								quantity
							}
						}
					}
					"""
            },
            PostScript: """
            {
                "batches": args.previewMoBatch.moBatches
            }
            """,
        },
		{
            Name:        "createManufacturingOrders",
            Description: "Creates Manufacturing Orders for each generated batch.",
            ForEach:     "context.pipeline.previewMoBatch.batches",
            Test:        "size(context.pipeline.previewMoBatch.batches) > 0",
            PreScript: """
			{
				"input": {
					"bomId": each.bomId,
					"quantity": each.quantity,
					"name": each.name,
					"moBatchId": context.pipeline.createMOBatch.moBatchId
				}
			}
			"""
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation createManufacturingOrders($input: createManufacturingInput!) {
                    createManufacturingOrderAndWorkOrders(input: $input) {
                        manufacturingOrderId
                    }
                }
                """
            }
        },
	]
}
