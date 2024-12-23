package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

previewManufacturingOutput: {
	Name: "previewManufacturingOutput"
	Fields: [
		{Name: "outputQuantity", Type: pipeline.Float, Required: true},
		{
			Name:  "workOperations"
			Array: true
			Type: {
				Name: "listPickingOperationResult"
				Fields: [
					{Name: "id", Type: pipeline.ID},
					{Name: "workCenterId", Type: pipeline.ID},
					{Name: "duration", Type: pipeline.Float},
					{Name: "order", Type: pipeline.Int},
					{Name: "calculatedDuration", Type: pipeline.Float},
					{Name: "documentUrl", Type: pipeline.String},
					{Name: "description", Type: pipeline.String},
					{Name: "name", Type: pipeline.String},
					{Name: "isActive", Type: pipeline.Boolean},
					{Name: "workCenter", Type: pipeline.String},
				]
			}
		},
		{
			Name:  "requiredItems"
			Array: true
			Type: {
				Name: "listPickingItemResult"
				Fields: [
					{Name: "id", Type: pipeline.ID},
					{Name: "itemId", Type: pipeline.ID},
					{Name: "uomId", Type: pipeline.ID},
					{Name: "outputQuantity", Type: pipeline.Float},
				]
			}
		}
	]
}

previewManufacturing: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "previewManufacturing"
	Description: """
		The purpose of this operation is to preview the manufacturing details based on a specific Bill of Materials (BOM). The steps involved are as follows:
		
		1. Fetch all operations and required BOM line items based on the given BOM ID and output quantity.
	"""
	Response: {Type: previewManufacturingOutput}
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "previewManufacturingInput"
				Fields: [
					{Name: "bomId", Type: pipeline.ID, Required: true},
					{Name: "outputQuantity", Type: pipeline.Float, Required: true},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "fetchOperationsAndBOMLineItems"
			Description: "Fetches all operations and required BOM line items based on the given BOM ID and output quantity"
			PreScript: """
					{
						'bomId': context.args.input.bomId,
						'outputQuantity': context.args.input.outputQuantity
					}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
						query fetchOperationsAndBOMLineItems($bomId: ID!,$outputQuantity:Float!) {
							simulateWorkOperation(
								input: {bomId: $bomId,outputQuantity: $outputQuantity}
							) {
								outputQuantity
								result {
									calculatedDuration
									description
									documentUrl
									duration
									order
									id
									isActive
									name
									workCenter
									workCenterId
								}
							}
						simulateInputRequirementByOutputQuantity(input: {bomId:$bomId, outputQuantity:  $outputQuantity}) {
                            result {
                                    id
                                    itemId
                                    outputQuantity
                                    uomId
                            }
                            outputQuantity
                        }

						}"""
			}
			PostScript: """
					{
						"outputQuantity":context.args.input.outputQuantity,
						"workOperations": args.simulateWorkOperation.result,
						"requiredItems": args.simulateInputRequirementByOutputQuantity.result,
					}"""
		},
	]
}
