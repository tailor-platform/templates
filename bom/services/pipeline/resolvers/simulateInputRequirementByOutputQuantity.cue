package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

listPickingResult: {
	Name: "listPickingResult"
	Fields: [
		{Name: "outputQuantity", Type: pipeline.Float, Required: true},
		{
			Name:  "result"
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
		},
	]
}

simulateInputRequirementByOutputQuantity: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "simulateInputRequirementByOutputQuantity"
	Description:   "Simulate the Input Quantity requirement of a BOM by the output quantity"
	Response: {Type: listPickingResult}
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "SimulateInputRequirementByOutputQuantityInput"
				Fields: [
					{Name: "bomId", Type: pipeline.ID, Required: true},
					{Name: "outputQuantity", Type: pipeline.Float, Required: true},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "fetchBOMLineItems"
			Description: "Fetch all BOM line items"
			PreScript: """
					{
						'bomId': context.args.input.bomId
					}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
						query fetchBOMLineItems($bomId: ID!) {
							bom(id: $bomId) {
								name
								outputQuantity
								id
							}
							bomLineItems(query: {bomId: {eq: $bomId}}) {
								collection {
										id
										bomId
										itemId
										item {
											name
											description
										}
										inputQuantity
										uomId
								}
							}
						}"""
			}
			PostScript: """
					{
						"bomLineItems": args.bomLineItems,
						"outputQuantity":context.args.input.outputQuantity,
						"result": size(args.bomLineItems.collection)== 0 ? [] : args.bomLineItems.collection.map(e, {
							"id": e.id,
							"itemId": e.itemId,
							"uomId": e.uomId,
							"outputQuantity": (context.args.input.outputQuantity/args.bom.outputQuantity) * e.inputQuantity 
						})
					}"""
			PostValidation: """
					size(context.pipeline.fetchBOMLineItems.bomLineItems.collection) == 0 ?
					['No items found for ',context.args.input.bomId].join(''):
					''
				"""
		},
	]
}
