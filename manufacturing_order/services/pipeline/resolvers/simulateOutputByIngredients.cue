package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

simulateInput:{
            Name: "SimulateOutputByIngredientsInput"
            Fields: [
                { Name: "bomId", Type: pipeline.ID},
                {
                    Name: "inputQuantities",
                    Array: true,
                    Type: {
                        Name: "listInput",
                        Fields: [
                            { Name: "itemId", Type: pipeline.ID },
                            { Name: "uomId", Type: pipeline.ID },
                            { Name: "inputQuantity", Type: pipeline.Float },
                        ]
                    }
                }
            ]
	}

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

simulateOutputByIngredients: pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure
    Name:        "simulateOutputByIngredients"
    Description: "Simulate the Input Quantity requirement of a BOM by the output quantity"
   	Response: {Type: listPickingResult}
    Inputs:[
        {
			Name: "input",
			Required: true,
			Type: simulateInput
        }
    ]
    Pipelines: [
        {
            Name:        "fetchBOMLineItems"
            Description: "Fetch all BOM line items"
            PreScript:   """
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
                                    inputQuantity
                                    uomId
                            }
                        }
                    }"""
            }
            PostHook: common.#Script & {
                Expr: """
                    (() => {
                        if(!args.bom){
                            return {
                                success: false,
                                error: `No BOM found with id ${context.args.input.bomId}`
                            }
                        }
                        const { collection: lineItems } = args.bomLineItems;
                        const { outputQuantity } = args.bom;
                        const { inputQuantities } = context.args.input;

                        if (!lineItems?.length) {
                            return {
                                success: false,
                                finalQuantity: 0,
                                items: `No BOM line items found for BOM with id ${context.args.input.bomId}`
                            }
                        }

                        if (!inputQuantities?.length) {
                            return {
                                success: true,
                                finalQuantity: 0,
                                items: []
                            }
                        }

                        const bomLineItemsForEachQuantity = lineItems.map(e => ({
                            id: e.id,
                            itemId: e.itemId,
                            uomId: e.uomId,
                            outputQuantity: e.inputQuantity / outputQuantity
                        }))

                        const bomLineItemsForGivenQuantity = inputQuantities.map(e => {
                            const item = bomLineItemsForEachQuantity.find(i => i.itemId === e.itemId)
                            return {
                                itemId: e.itemId,
                                inputUOMId: e.uomId,
                                itemUomId:item.uomId,
                                inputQuantity: e.inputQuantity,
                                itemOutputQuantity: item ? item.outputQuantity : 0,
                            }
                        })

                        return {
                            success: true,
                            items: bomLineItemsForGivenQuantity,
                            bomLineItemsForEachQuantity:bomLineItemsForEachQuantity
                        }
                    })()
                """
            }
            PostValidation: """
                context.pipeline.fetchBOMLineItems.success ? '' : context.pipeline.fetchBOMLineItems.error
            """
        },
        {
			Name:        "convertUOM"
			Description: "convertUOM"
			ForEach:	 "context.pipeline.fetchBOMLineItems.items"
			Test: 		 "size(context.pipeline.fetchBOMLineItems.items) > 0"
			PreScript: """
			{
				"fromUOMId": each.inputUOMId,
				"toUOMId": each.itemUomId,
				"quantity": each.inputQuantity
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query convertQuantity($fromUOMId: ID!, $toUOMId: ID!, $quantity: Float!) {
			  		convertQuantity(input: {fromUOMId: $fromUOMId, toUOMId: $toUOMId, quantity: $quantity}){
                        convertedQuantity
                    }
				}"""
			}
            PostHook: common.#Script & {
                Expr: """
                    (() => {
                        return {
                            itemId:each.itemId,
                            inputUOMId:each.inputUOMId,
                            itemUomId:each.itemUomId,
                            inputQuantity:each.inputQuantity,
                            itemOutputQuantity:each.itemOutputQuantity,
                            convertedQuantities: args.convertQuantity.convertedQuantity,
                        }
                    })()
                """
            }
		},
        {
			Name:        "getListOfRequiredItems"
			Description: "Fetch conversion factor from uomConversions table"
            PreHook: common.#Script & {
                Expr: """
                    (() => {
                        const convertedData = context.pipeline.convertUOM

                        const outputQuantityRequiredForEach = convertedData.map((e) =>
                            ({
                                outputQuantity: e.convertedQuantities/e.itemOutputQuantity
                            })
                        )

                        const finalQuantity = Math.min(...outputQuantityRequiredForEach.map(e => e.outputQuantity))
                        return {
                            bomId: context.args.input.bomId,
                            finalQuantity: finalQuantity < 1 ? 0 : Math.floor(finalQuantity),
                            outputQuantityRequiredForEach:outputQuantityRequiredForEach
                        }
                    })()
                """
            }
			Operation: pipeline.#GraphqlOperation & {
				Query: """
                    query getListOfRequiredItems($bomId: ID!, $finalQuantity: Float!) {
                        simulateInputRequirementByOutputQuantity(input: {bomId:$bomId, outputQuantity:  $finalQuantity}) {
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
                    "result":  args.simulateInputRequirementByOutputQuantity.outputQuantity == 0 ? [] : get(args.simulateInputRequirementByOutputQuantity.result),
                    "outputQuantity": get(args.simulateInputRequirementByOutputQuantity.outputQuantity, 0)
                }"""
		},
    ]
}
