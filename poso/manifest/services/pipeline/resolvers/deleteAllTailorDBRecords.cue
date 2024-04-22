package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

deleteAllTailorDBRecords: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "deleteAllTailorDBRecords"
	Description: """
	DANGER: Delete all the records in the database. This is a resolver for development purpose only.
	"""
	Response: { Type: standardPipelineResult }
	PostScript: """
	{
		"result": string(
				size(context.pipeline.getRecords.taxes.collection) 
				+ size(context.pipeline.getRecords.taxes.collection) 
				+ size(context.pipeline.getRecords.products.collection) 
				+ size(context.pipeline.getRecords.contacts.collection) 
				+ size(context.pipeline.getRecords.documentTypes.collection) 
				+ size(context.pipeline.getRecords.documentStatuses.collection) 
				+ size(context.pipeline.getRecords.documentTemplates.collection) 
				+ size(context.pipeline.getRecords.documents.collection) 
				+ size(context.pipeline.getRecords.lineItems.collection)
				+ size(context.pipeline.getRecords.stockEvents.collection)
				+ size(context.pipeline.getRecords.stockHistories.collection)
				+ size(context.pipeline.getRecords.stockSummaries.collection)
			) +" Record(s) deleted",
		"error": ""
	}"""
	Pipelines: [
		{
			Name:        "getRecords"
			Description: "Get all the records from all the tailordb models."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query getRecords {
					taxes(size: 100000){
						collection{
							id
						}
					}
					products(size: 100000){
						collection{
							id
						}
					}
					contacts(size: 100000){
						collection{
							id
						}
					}
					documentTypes(size: 100000){
						collection{
							id
						}
					}
					documentStatuses(size: 100000){
						collection{
							id
						}
					}
					documentTemplates(size: 100000){
						collection{
							id
						}
					}
					documents(size: 100000){
						collection{
							id
						}
					}
					lineItems(size: 100000){
						collection{
							id
						}
					}
					stockEvents(size: 100000){
						collection{
							id
						}
					}
					stockHistories(size: 100000){
						collection{
							id
						}
					}
					stockSummaries(size: 100000){
						collection{
							id
						}
					}
					users(size: 100000){
						collection{
							id
						}
					}
					roles(size: 100000){
						collection{
							id
						}
					}
				}"""
			}
			PostScript: "args"
		},
		{
			Name:        "deleteTaxes"
			Description: "Delete the Tax records fetched in the step 1"
			ForEach:	 "context.pipeline.getRecords.taxes.collection"
			Invoker:     settings.adminInvoker
			Test: 		 "size(context.pipeline.getRecords.taxes.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"taxID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteTax($taxID: ID!) {
				deleteTax(id: $taxID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteTax
			}"""
		},
		{
			Name:        "deleteProducts"
			Description: "Delete the Product records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.products.collection"
			Test: 		 "size(context.pipeline.getRecords.products.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"productID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteProduct($productID: ID!) {
				deleteProduct(id: $productID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteProduct
			}"""
		},
		{
			Name:        "deleteContacts"
			Description: "Delete the Contact records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.contacts.collection"
			Test: 		 "size(context.pipeline.getRecords.contacts.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"contactID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteContact($contactID: ID!) {
				deleteContact(id: $contactID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteContact
			}"""
		},
		{
			Name:        "deleteDocumentTypes"
			Description: "Delete the DocumentType records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.documentTypes.collection"
			Test: 		 "size(context.pipeline.getRecords.documentTypes.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"documentTypeID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteDocumentType($documentTypeID: ID!) {
				deleteDocumentType(id: $documentTypeID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteDocumentType
			}"""
		},
				{
			Name:        "deleteDocumentStatuses"
			Description: "Delete the DocumentType records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.documentStatuses.collection"
			Test: 		 "size(context.pipeline.getRecords.documentStatuses.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"documentStatusID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteDocumentStatus($documentStatusID: ID!) {
				deleteDocumentStatus(id: $documentStatusID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteDocumentStatus
			}"""
		},
		{
			Name:        "deleteDocumentTemplates"
			Description: "Delete the DocumentTemplate records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.documentTemplates.collection"
			Test: 		 "size(context.pipeline.getRecords.documentTemplates.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"documentTemplateID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteDocumentTemplate($documentTemplateID: ID!) {
				deleteDocumentTemplate(id: $documentTemplateID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteDocumentTemplate
			}"""
		},
		{
			Name:        "deleteDocuments"
			Description: "Delete the Document records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.documents.collection"
			Test: 		 "size(context.pipeline.getRecords.documents.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"documentID": each.id,
			}
			"""
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
			Name:        "deleteLineItems"
			Description: "Delete the LineItem records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.lineItems.collection"
			Test: 		 "size(context.pipeline.getRecords.lineItems.collection) > 0" // skip if no records are found
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
		{
			Name:        "deleteStockEvents"
			Description: "Delete the StockEvent records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.stockEvents.collection"
			Test: 		 "size(context.pipeline.getRecords.stockEvents.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"stockEventID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteStockEvent($stockEventID: ID!) {
				deleteStockEvent(id: $stockEventID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteStockEvent
			}"""
		},
		{
			Name:        "deleteStockHistories"
			Description: "Delete the StockHistory records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.stockHistories.collection"
			Test: 		 "size(context.pipeline.getRecords.stockHistories.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"stockHistoryID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteStockHistory($stockHistoryID: ID!) {
				deleteStockHistory(id: $stockHistoryID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteStockHistory
			}"""
		},
		{
			Name:        "deleteStockSummaries"
			Description: "Delete the StockSummary records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.stockSummaries.collection"
			Test: 		 "size(context.pipeline.getRecords.stockSummaries.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"stockSummaryID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteStockSummary($stockSummaryID: ID!) {
				deleteStockSummary(id: $stockSummaryID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteStockSummary
			}"""
		},
		{
			Name:        "deleteUsers"
			Description: "Delete the User records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.users.collection"
			Test: 		 "size(context.pipeline.getRecords.users.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"userID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteUser($userID: ID!) {
				deleteUser(id: $userID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteUser
			}"""
		},
		{
			Name:        "deleteRoles"
			Description: "Delete the Role records fetched in the step 1"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.roles.collection"
			Test: 		 "size(context.pipeline.getRecords.roles.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"roleID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteRole($roleID: ID!) {
				deleteRole(id: $roleID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteRole
			}"""
		}
	]
}
