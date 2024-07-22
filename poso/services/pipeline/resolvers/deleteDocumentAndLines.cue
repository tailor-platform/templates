package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

deleteDocumentAndLines: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "deleteDocumentAndLines"
	Description: """
		The purpose of this Pipeline is to delete a document and all of its associated line items.
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "deleteDocumentAndLinesInput"
				Fields: [
					{Name: "documentID", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {Type: standardPipelineResult}
	// is true if the document and all of its associated line items are deleted
	// or if the document is deleted and there are no associated line items
	// or if the document does not exist and all its associated line items are deleted
	PostScript: """
			{
				"result": (isNull(context.pipeline.getDocument) && size(context.pipeline.getLineItems) == 0) ? 
				"" : string(
					size(context.pipeline.deleteLineItems) + (isNull(context.pipeline.getDocument) ? 0 : 1)
					) + " Record(s) deleted" ,
				"error": (isNull(context.pipeline.getDocument) && size(context.pipeline.getLineItems) == 0) ? 
					"A document and lineItems with the provided documentID were not found" : ""
			}"""
	Pipelines: [
		{
			Name:        "getDocument"
			Description: "Get the original document."
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query document ($documentID: ID!) {
										document(id: $documentID) {
											id
										}
									}"""
			}
			PostScript: "args.document"
		},
		{
			Name:        "deleteDocument"
			Description: "Delete the Document"
			Invoker:     settings.adminInvoker
			Test:        "!isNull(context.pipeline.getDocument)" // skip if no document is found
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation deleteDocument($documentID: ID!) {
									deleteDocument(id: $documentID)
									}"""
			}
			PostScript: """
							{
								"result": args.deleteDocument
							}"""
		},
		{
			Name:        "getLineItems"
			Description: "Get the LineItem records associated with the Document ID."
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query lineItems ($documentID: ID!) {
										lineItems(query: { documentID: { eq: $documentID }}, size: 100000) {
											collection {
												id
											}
										}
									}"""
			}
			PostScript: "args.lineItems.collection"
		},
		{
			Name:        "deleteLineItems"
			Description: "Delete the LineItem records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getLineItems"
			Test:        "size(context.pipeline.getLineItems) > 0" // skip if no records are found
			PreScript: """
				{
					"lineItemID": each.id,
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation deleteLineItem($lineItemID: ID!) {
									deleteLineItem(id: $lineItemID)
									}"""
			}
			PostScript: """
							{
								"result": args.deleteLineItem
							}"""
		},
	]
}
