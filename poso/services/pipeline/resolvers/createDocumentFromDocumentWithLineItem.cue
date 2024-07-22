package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

createDocumentFromDocumentWithLineItem: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createDocumentFromDocumentWithLineItem"
	Description: """
		The purpose of this Pipeline is to copy a document and create another document in document table as well as dupulicating the LineItems used in the original document for the new document.
		This Pipeline follows the following steps:
		1. Get all the LineItem records used in the original document.
		2. Create a record in the Document table.
		3. Create LineItem records in the LineItem table for the new document.
		4. Run the calculateDocument to update both LineItemCalc and Document records.
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createDocumentFromDocumentWithLineItemInput"
				Fields: [
					{Name: "originalDocumentID", Type: pipeline.ID, Required: true},
					{Name: "documentTypeID", Type: pipeline.ID, Required: false},
					{Name: "documentTemplateID", Type: pipeline.ID, Required: false},
					{Name: "contactID", Type: pipeline.ID, Required: false},
					{Name: "code", Type: pipeline.String, Required: false},
					{Name: "date", Type: pipeline.Date, Required: false},
				]
			}
		},
	]
	Response: {Type: standardPipelineResult}
	PostScript: """
			{
				"result": isNull(context.pipeline.createDocument)? "" : context.pipeline.createDocument.id,
				"error": isNull(context.pipeline.getDocument)? "A document with the given ID does not exist." : ""
			}"""
	Pipelines: [
		{
			Name:        "getDocument"
			Description: "Get the original document."
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query document ($originalDocumentID: ID!) {
										document(id: $originalDocumentID) {
											id
											contactID
											documentTypeID
											documentTemplateID
										}
									}"""
			}
			PostScript: "args.document"
		},
		{
			Name:        "getLineItems"
			Description: "Get the LineItem records associated with the Document ID."
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query lineItems ($originalDocumentID: ID!) {
										lineItems(query: { documentID: { eq: $originalDocumentID } }, size: 10000) {
											collection {
												id
												name
												quantity
												unitPrice
												productID
												unitCost
												documentID
												taxID
											}
										}
									}"""
			}
			PostScript: "args.lineItems.collection"
		},
		// get the default defaultDocumentStatusID from documentType
		{
			Name:        "getDefaultDocumentStatusID"
			Description: "Get the DocumentType record."
			Invoker:     settings.adminInvoker
			Test:        "!isNull(context.args.input.documentTypeID)"
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query documentType ($documentTypeID: ID!) {
										documentType(id: $documentTypeID) {
											id
											defaultDocumentStatusID
										}
									}"""
			}
			PostScript: "isNull(args.documentType) ? null : args.documentType.defaultDocumentStatusID"
		},
		{
			Name:        "createDocument"
			Test:        "!isNull(context.pipeline.getDocument)"
			Invoker:     settings.adminInvoker
			Description: "Use the data in the original document as inputs for creating a new Document record."
			PreScript: """
				{
					"input": {
						"contactID": isNull(context.args.input.contactID) ? context.pipeline.getDocument.contactID : context.args.input.contactID,
						"documentTypeID": isNull(context.args.input.documentTypeID) ? context.pipeline.getDocument.documentTypeID : context.args.input.documentTypeID,
						"documentTemplateID": isNull(context.args.input.documentTemplateID) ? context.pipeline.getDocument.documentTemplateID : context.args.input.documentTemplateID,
						"code": isNull(context.args.input.code) ? null : context.args.input.code,
						"date": isNull(context.args.input.date) ? null : context.args.input.date,
						"documentStatusID": context.pipeline.getDefaultDocumentStatusID,
						"isCalculated": false
					}
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation createDocument ($input: DocumentCreateInput!) {
										createDocument(input: $input) {
											id
										}
									}"""
			}
			PostScript: "args.createDocument"
		},
		{
			Name:        "createLineItems"
			Test:        "!isNull(context.pipeline.createDocument)"
			Invoker:     settings.adminInvoker
			Description: "Use the result of step 2 and populate the new lineitems for the new document."
			ForEach:     "context.pipeline.getLineItems"
			PreScript: """
							{
								"lineItems": [compact({
									"id": null,
									"productID": each.productID,
									"name": each.name,
									"unitCost": each.unitCost,
									"unitPrice": each.unitPrice,
									"quantity": each.quantity,
									"taxID": each.taxID,
								})],
								"documentID": context.pipeline.createDocument.id
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation BulkUpsertAndCalculateLineItems(
									$lineItems: [BUCLineItem]!
									$documentID: ID!
								) {
									bulkUpsertAndCalculateLineItems(
										input: { lineItems: $lineItems, documentID: $documentID }
									) {
										result
										error
									}
								}"""
			}
			PostScript: """
							{
								"result": args.bulkUpsertAndCalculateLineItems
							}"""
		},
		{
			Name:        "calculateDocument"
			Description: "Run the calculateDocument pipeline to refresh the Document and LineItemCalc table."
			Invoker:     settings.adminInvoker
			Test:        "!isNull(context.pipeline.createDocument)"
			PreScript: """
				{
					"documentID": context.pipeline.createDocument.id,
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation calculateDocument ($documentID: ID!) {
										calculateDocument(input: { documentID: $documentID }){
											result
											error
										}
									}"""
			}
			PostScript: """
							{
								"result": args.calculateDocument.result,
							}"""
		},
	]
}
