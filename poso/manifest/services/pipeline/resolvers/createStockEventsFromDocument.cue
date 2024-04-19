package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

createStockEventsFromDocument: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "createStockEventsFromDocument"
	Description: """
	The purpose of this Pipeline is to create a StockEvent for each LineItem in a document
	This Pipeline follows the following steps
	1 Get all the products with type INVENTORY
	2 Get all the LineItem records used in the original document (with products of type INVENTORY)
	3 Create a stock event for each LineItem record
	4 Get the stockEvents generated for the document
	5 Run calculateStockEventAndUpdateStockSummary pipeline to refresh the StockEvent and StockEventCalc table"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createStockEventsFromDocumentInput"
				Fields: [
					{Name: "documentID", Type: pipeline.ID, Required:  true},
					{Name: "isAdding", Type: pipeline.Boolean, Required:  true},
				]
			}
		},
	]
	Response: { Type: standardPipelineResult }
	PostScript: """
	{
		"result": !isNull(context.pipeline.document.error) ? "" 
			: string(size(context.pipeline.calculateStockEventAndUpdateStockSummary)) + " Record(s) updated",
		"error": context.pipeline.document.error
	}"""
	Pipelines: [
		{
			Name:        "document"
			Description: "Verify that the Document and LineItem records exist in the database before proceeding with the aggregation and update process."
			Invoker:     settings.adminInvoker
			PreScript: "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query document ($documentID: ID!){
					document(id: $documentID) {
						id
						documentType{
							name
						}
						documentStatus{
							name
							triggersStockEvent
						}
					}
				}"""
			}
			PostScript: """
			{
				"result": args.document,
				"error": isNull(args.document) ? 
					"A document with the provided ID was not found" 
					: !args.document.documentStatus.triggersStockEvent 
					? "A " + args.document.documentType.name + " in state " + args.document.documentStatus.name + " does not trigger stock events"
					: ""
			}"""
		},
		// 1 Get all the ids of products with type INVENTORY
		{
			Name:        "getInventoryProductIDs"
			Description: "Get all the products with type INVENTORY"
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query products {
					products(query: { inventoryType: { eq: INVENTORY } }) {
						collection {
							id
						}
					}
				}"""
			}
			PostScript: "args.products.collection.map(e, e.id)"
		},
		// 2 Get all the LineItem records used in the original document.
		{
			Name:        "getLineItems"
			Description: "Get the LineItem records associated with the Document ID."
			Invoker:     settings.adminInvoker
			PreScript: """
			{
				"documentID": context.args.input.documentID,
				"productIDs": context.pipeline.getInventoryProductIDs
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query lineItems ($documentID: ID!, $productIDs: [ID]) {
					lineItems(query: { documentID: { eq: $documentID }, productID: { in: $productIDs }}) {
						collection {
							id
							name
							quantity
							unitPrice
							productID
							unitCost
							documentID
						}
					}
				}"""
			}
			PostScript: "isNull(context.pipeline.document.result)? [] : args.lineItems.collection"
		},
		// 3. Create a stock event for each LineItem record
		{
			Name:        "createStockEvent"
			Description: "Create a StockEvent for each LineItem record."
			Invoker:     settings.adminInvoker
			Test: "context.pipeline.document.error == '' && !isNull(context.pipeline.getLineItems) && size(context.pipeline.getLineItems) > 0"
			ForEach: "context.pipeline.getLineItems"
			PreScript: """
			{
				"input": compact({
					"productID": each.productID,
					"unitCost": each.quantity,
					"incrementalQuantity": (context.args.input.isAdding) ? each.quantity : (-1.00 * each.quantity),
					"documentID": context.args.input.documentID,
				})
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation createStockEvent($input: StockEventCreateInput!) {
					createStockEvent(input: $input) {
						id
					}
				}"""
			}
			PostScript: "args.createStockEvent"
		},
		// 4. Get the stockEvents generated for the document
		{
			Name:        "getStockEvents"
			Description: "Get the StockEvents generated for the document."
			Invoker:     settings.adminInvoker
			PreScript: "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query stockEvents ($documentID: ID!) {
					stockEvents(query: { documentID: { eq: $documentID } }) {
						collection {
							id
							productID
							unitCost
							incrementalQuantity
							documentID
						}
					}
				}"""
			}
			PostScript: "args.stockEvents.collection"
		},
		// 5. Run calculateStockEventAndUpdateStockSummary pipeline to refresh the StockEvent and StockEventCalc table.
		{
			Name:        "calculateStockEventAndUpdateStockSummary"
			Description: "Run calculateStockEventAndUpdateStockSummary pipeline to refresh the StockEvent and StockEventCalc table."
			Invoker:     settings.adminInvoker
			Test: "context.pipeline.document.error == '' && size(context.pipeline.getStockEvents) > 0"
			ForEach: "context.pipeline.getStockEvents"
			PreScript: """
			{
				"stockEventID": each.id
			}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation calculateStockEventAndUpdateStockSummary($stockEventID: ID!) {
					calculateStockEventAndUpdateStockSummary(input: { stockEventID: $stockEventID }){
						result
					}
				}"""
			}
			PostScript: """
			{
				"result": args.calculateStockEventAndUpdateStockSummary.result
			}"""
		},
	]
}
