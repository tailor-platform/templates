package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

calculateDocuments: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "calculateDocuments"
	Description: """
		The purpose of this Pipeline is to refresh Document table by aggregating the LineItem table to calculate the sum of the subtotalAmount, subtotalCost, taxAmount and totalAmount for each documentID. Then store the result to Document.
		This Pipeline follows the following steps:
		1. Get all the Document records, where isCalculated is false. These are the records that need update.
		2. Aggregate the LineItem records to calculate the total amount for each document.
		3. Update Document records based on the result of the aggregation.
		"""
	PostScript: """
			{
				"result":string(size(context.pipeline.updateDocument)) + " Record(s) updated",
				"error": ""
			}"""
	Response: {Type: standardPipelineResult}
	Pipelines: [
		{
			Name:        "documents"
			Description: "Get all the Document records, where isCalculated is false. These are the records that need update."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query documents {
									documents(query: { isCalculated: { eq: false } }) {
										collection {
										id
										}
									}
									}"""
			}
			PostScript: """
							{
								"documents": args.documents,
							}"""
		},
		{
			Name:        "aggregateLineItems"
			Description: "Aggregate the LineItem records to calculate the totals for each document."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query aggregateLineItems {
									aggregateLineItems {
										groupBy {
											documentID
										}
										sum {
											subtotalAmount
											subtotalCost
											taxAmount
											totalAmount
										}
									}
									}"""
			}
			PostScript: """
							{
								"aggregateLineItems": args.aggregateLineItems
							}"""
		},
		{
			Name:        "updateDocument"
			Description: "Update Document records based on the result of the aggregation."
			Invoker:     settings.adminInvoker
			ForEach:     "args.aggregateLineItems"
			PreScript: """
							{
								"id": each.groupBy.documentID,
								"subtotalAmount": each.sum.subtotalAmount,
								"subtotalCost": each.sum.subtotalCost,
								"taxAmount": each.sum.taxAmount,
								"totalAmount": each.sum.totalAmount
							}"""
			// What happens if id is not found in the database?
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation ($id: ID!, $subtotalAmount: Float, $subtotalCost: Float, $taxAmount: Float, $totalAmount: Float) {
									updateDocument(id:$id, input: { subtotalAmount: $subtotalAmount, subtotalCost: $subtotalCost, taxAmount: $taxAmount, totalAmount: $totalAmount }) {
										id
									}
									}"""
			}
			PostScript: """
							{
								"result": args.updateDocument
							}"""
		},
	]
}
