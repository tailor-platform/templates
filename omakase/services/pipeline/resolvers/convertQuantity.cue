package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

convertQuantity: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "convertQuantity"
	Description:   "Convert the quantity of an item from one UOM to another UOM"
	Response: {
		Type: {
			Name: "ConvertQuantityOutput"
			Fields: [
				{Name: "convertedQuantity", Type: pipeline.Float},
			]
		}
	}
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "ConvertQuantityInput"
				Fields: [
					{Name: "fromUOMId", Type: pipeline.ID, Required: true},
					{Name: "toUOMId", Type: pipeline.ID, Required: true},
					{Name: "quantity", Type: pipeline.Float, Required: true},
				]
			}
		},
	]
	PostScript: """
	{
		'convertedQuantity': context.args.input.fromUOMId == context.args.input.toUOMId ?
			context.args.input.quantity :
			context.pipeline.fetchConversionFactor.convertedQuantity
	}
	"""
	Pipelines: [
		{
			Name:        "fetchConversionFactor"
			Description: "Fetch conversion factor from uomConversions table"
			Test:		"context.args.input.fromUOMId != context.args.input.toUOMId"
			PreScript: """
						{
							'fromUomId': context.args.input.fromUOMId,
							'toUomId':context.args.input.toUOMId
						}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
						query fetchConversionFactor($fromUomId: ID!, $toUomId: ID!) {
							uomConversions(query: {fromUomId: {eq: $fromUomId}, toUomId: {eq: $toUomId}}) {
								collection {
								conversionFactor
								}
							}
							from: uom(id: $fromUomId) {
								name
							}
							to: uom(id: $toUomId) {
								name
							}
						}
				"""
			}
			PostScript: """
						{
							"convertedQuantity": size(args.uomConversions.collection)== 0 ? 0 : context.args.input.quantity * args.uomConversions.collection[0].conversionFactor,
							"uomConversions": args.uomConversions,
							"from":isNull(args.from) ? "Invalid fromId": args.from.name,
							"to":isNull(args.to) ? "Invalid toId": args.to.name
						}
						"""
			PostValidation: """
					size(context.pipeline.fetchConversionFactor.uomConversions.collection) == 0 ?
					['No conversion factor found from ',context.pipeline.fetchConversionFactor.from,' to ',context.pipeline.fetchConversionFactor.to].join(''):
					''
				"""
		},
	]
}
