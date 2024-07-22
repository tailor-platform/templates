package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

calculateStockEventAndUpdateStockSummary: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "calculateStockEventAndUpdateStockSummary"
	Description: """
		The purpose of this Pipeline is to calculate the stockEventCalc for a stockEvent
		This Pipeline follows the following steps
		1. Get the stock event
		2. Get StockSummary record for the productID in the stock event.
		3. Update the stockEvent, calculating transactionTotalCost, totalQuantity, totalCost and averageCost
		4. Delete the StockSummary records obtained in step 3.
		5. Create a new StockSummary record for the productID in the stock event, using the result of step 3.
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "calculateStockEventAndUpdateStockSummaryInput"
				Fields: [
					{Name: "stockEventID", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {Type: standardPipelineResult}
	PostScript: """
			{
				"result": (!isNull(context.pipeline.updateStockEvent) && !isNull(context.pipeline.createStockSummary.result))? "1 Record(s) updated" : "",
				"error": isNull(context.pipeline.getStockEvent.result) ? 
					"No stock event found with the stockEventID provided for a product with type INVENTORY." 
					: !context.pipeline.getStockEvent.canBeRecalculated ? 
					"The stock event was already calculated. To recalculate it use the recalculateStockEventAndSummary pipeline"
					: ""
			}"""
	Pipelines: [
		// Get all the ids of products with type INVENTORY
		{
			Name:        "getInventoryProductIDs"
			Invoker:     settings.adminInvoker
			Description: "Get all the products with type INVENTORY"
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
		// 1. Get the stock event
		{
			Name:        "getStockEvent"
			Description: "Get the stock event product."
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.getInventoryProductIDs) > 0"
			PreScript: """
							{
								"stockEventID": context.args.input.stockEventID,
								"productIDs": context.pipeline.getInventoryProductIDs
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query stockEvent($stockEventID: ID!, $productIDs: [ID]) {
										stockEvents(query: {id: {eq: $stockEventID}, productID: {in: $productIDs}} ) {
											collection {
												id
												unitCost
												incrementalQuantity
												productID
												totalQuantity
											}
										}
									}"""
			}
			PostScript: """
							{
								"result": size(args.stockEvents.collection) > 0 ? args.stockEvents.collection[0]: null,
								"canBeRecalculated": isNull(args.stockEvent.totalQuantity)
							}"""
		},
		// 2. Get StockSummary record for the productID in the stock event.
		{
			Name:        "getStockSummary"
			Description: "Get the most recent stock data."
			Invoker:     settings.adminInvoker
			Test:        "!isNull(context.pipeline.getStockEvent.result) && context.pipeline.getStockEvent.canBeRecalculated"
			PreScript: """
							{
								"stockEventProductID": context.pipeline.getStockEvent.result.productID
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query stockSummaries($stockEventProductID: ID!) {
										stockSummaries(query: {productID: {eq: $stockEventProductID}}) {
											collection{
												id
												productID
												totalQuantity
												totalCost
												averageCost
											}
										}
									}"""
			}
			PostScript: "args.stockSummaries.collection"
		},
		// 3. Update the stockEvent, calculating transactionTotalCost, totalQuantity, totalCost and averageCost
		{
			Name:        "updateStockEvent"
			Description: "Create a stock event calc."
			Invoker:     settings.adminInvoker
			Test:        "!isNull(context.pipeline.getStockEvent.result) && context.pipeline.getStockEvent.canBeRecalculated"
			PreScript: """
							{
								"id": context.pipeline.getStockEvent.result.id,
								"input": compact({
									"totalQuantity": (size(context.pipeline.getStockSummary) > 0 ? context.pipeline.getStockSummary[0].totalQuantity:  0.0) + context.pipeline.getStockEvent.result.incrementalQuantity,
									"totalCost": (size(context.pipeline.getStockSummary) > 0 ? context.pipeline.getStockSummary[0].totalCost : 0.0) + (context.pipeline.getStockEvent.result.unitCost * context.pipeline.getStockEvent.result.incrementalQuantity),
								})
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation updateStockEvent($id: ID!, $input: StockEventUpdateInput!) {
										updateStockEvent(id: $id, input: $input) {
											id
											productID
											totalQuantity
											totalCost
											averageCost
										}
									}"""
			}
			PostScript: "args.updateStockEvent"
		},
		// 4. Delete the StockSummary records obtained in step 3.
		{
			Name:        "deleteStockSummary"
			Description: "Delete the stock summary."
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.getStockSummary) > 0 && !isNull(context.pipeline.getStockEvent.result) && context.pipeline.getStockEvent.canBeRecalculated" // Skip if there is no stock summary to delete
			ForEach:     "isNull(context.pipeline.getStockSummary) ? [] : context.pipeline.getStockSummary"
			PreScript: """
							{
								"id": each.id
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation deleteStockSummary($id: ID!) {
										deleteStockSummary(id: $id)
									}"""
			}
			PostScript: """
							{
								"result": args.deleteStockSummary
							}"""
		},
		// 5. Create a new StockSummary record for the productID in the stock event, using the result of step 3.
		{
			Name:        "createStockSummary"
			Description: "Create a stock summary."
			Invoker:     settings.adminInvoker
			Test:        "!isNull(context.pipeline.getStockEvent.result) && context.pipeline.getStockEvent.canBeRecalculated"
			PreScript: """
							{
								"input": compact({
									"productID": context.pipeline.updateStockEvent.productID,
									"totalQuantity": context.pipeline.updateStockEvent.totalQuantity,
									"totalCost": context.pipeline.updateStockEvent.totalCost,
								})
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation createStockSummary($input: StockSummaryCreateInput!) {
										createStockSummary(input: $input) {
											id
										} 
									}"""
			}
			PostScript: """
							{
								"result": args.createStockSummary.id
							}"""
		},
	]
}
