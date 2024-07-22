package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

calculateDocument: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "calculateDocument"
	Description: """
		The purpose of this Pipeline is to refresh Document table by aggregating the LineItem table to calculate the sum of the subtotalAmount, subtotalCost, taxAmount and totalAmount for each documentID. Then store the result to Document.
		This Pipeline follows the following steps:
		1. Take as input the documentID of the Document to be refreshed.
		2. Aggregate the LineItem records to calculate the total amount for the Document.
		3. Update the Document based on the result of the aggregation.
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "calculateDocumentInput"
				Fields: [
					{Name: "documentID", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	PostScript: """
			{
				"result": (isNull(context.pipeline.updateDocument) && (isNull(context.pipeline.updateDocumentNoLines)))? "" : "1 Record(s) updated",
				"error": context.pipeline.document.error
			}"""
	Response: {Type: standardPipelineResult}
	Pipelines: [
		{
			Name:        "document"
			Description: "Verify that the Document and LineItem records exist in the database before proceeding with the aggregation and update process."
			PreScript:   "context.args.input"
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query document ($documentID: ID!){
									document(id: $documentID) {
										id
									}
									lineItems(query: { documentID: { eq: $documentID } }) {
											items
										}
									}"""
			}
			PostScript: """
							{
								"document": isNull(args.document) ? null : args.document.id,
								"lineItemCount": args.lineItems.items,
								"error": isNull(args.document) ? "A document with the provided ID was not found" : ""
							}"""
		},
		{
			Name:        "aggregateLineItems"
			Description: "Aggregate the LineItem records to calculate the totals for each document."
			Test:        "!isNull(context.pipeline.document.document)"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query aggregateLineItems  ( $documentID: ID) {
									aggregateLineItems (query: { documentID: { eq: $documentID } }){
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
					isNull(args.aggregateLineItems[0].groupBy.documentID) ? [] : args.aggregateLineItems[0]
				"""
		},
		{
			Name:        "updateDocument"
			Description: "Update Document records based on the result of the aggregation."
			Test:        "!isNull(context.pipeline.document.document) && context.pipeline.document.lineItemCount > 0"
			Invoker:     settings.adminInvoker
			PreScript: """
							{
								"id": context.pipeline.aggregateLineItems.groupBy.documentID,
								"subtotalAmount": context.pipeline.aggregateLineItems.sum.subtotalAmount,
								"subtotalCost": context.pipeline.aggregateLineItems.sum.subtotalCost,
								"taxAmount": context.pipeline.aggregateLineItems.sum.taxAmount,
								"totalAmount": context.pipeline.aggregateLineItems.sum.totalAmount
							}"""
			// What happens if id is not found in the database?
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation updateDocument ($id: ID!, $subtotalAmount: Float, $subtotalCost: Float, $taxAmount: Float, $totalAmount: Float) {
									updateDocument(id:$id, input: { subtotalAmount: $subtotalAmount, subtotalCost: $subtotalCost, taxAmount: $taxAmount, totalAmount: $totalAmount }) {
										id
									}
									}"""
			}
			PostScript: "args.updateDocument"
		},
		// If there are no lines in the document we set the sums to 0
		{
			Name:        "updateDocumentNoLines"
			Description: "Update the document with it's values as 0."
			Invoker:     settings.adminInvoker
			Test:        "!isNull(context.pipeline.document.document) && context.pipeline.document.lineItemCount < 1"
			PreScript: """
							{
								"id": context.args.input.documentID,
								"subtotalAmount": 0,
								"subtotalCost": 0,
								"taxAmount": 0,
								"totalAmount": 0
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation updateDocument ($id: ID!, $subtotalAmount: Float, $subtotalCost: Float, $taxAmount: Float, $totalAmount: Float) {
									updateDocument(id:$id, input: { subtotalAmount: $subtotalAmount, subtotalCost: $subtotalCost, taxAmount: $taxAmount, totalAmount: $totalAmount }) {
										id
									}
									}"""
			}
			PostScript: "args.updateDocument"
		},
	]
}
