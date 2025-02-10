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
								edges {
									node {
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
							}
						}"""
			}
			PostScript: """
					{
						"bomLineItems": args.bomLineItems,
						"outputQuantity":context.args.input.outputQuantity,
						"result": size(args.bomLineItems.edges)== 0 ? [] : args.bomLineItems.edges.map(e, {
							"id": e.node.id,
							"itemId": e.node.itemId,
							"uomId": e.node.uomId,
							"outputQuantity": (context.args.input.outputQuantity/args.bom.outputQuantity) * e.node.inputQuantity 
						})
					}"""
			PostValidation: """
					size(context.pipeline.fetchBOMLineItems.bomLineItems.edges) == 0 ?
					['No items found for ', context.args.input.bomId].join('') :
					''
				"""
		},
	]
}
