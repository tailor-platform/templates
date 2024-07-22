package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

createStockHistoryFromSummary: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createStockHistoryFromSummary"
	Description: """
		The purpose of this Pipeline is to create a new StockHistory based on the current StockSummary.
		Used to create a rollback point (or save point) for the stock.
		
		This Pipeline follows the following steps
		1. Get the most recent stock Summary data
		2. get the most recent Stock history data
		3. Create new stock history based on the current stock summary
		4. Delete the previous stock history
		"""
	Response: {Type: standardPipelineResult}
	PostScript: """
			{
				"result": string(size(context.pipeline.createStockHistory)) + " Record(s) updated.",
				"error": ""
			}"""
	Pipelines: [
		// 1. Get the most recent stock Summary data
		{
			Name:        "getStockSummary"
			Description: "Get the most recent stock data."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query stockSummaries {
										stockSummaries {
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
		// 2. get the most recent Stock history data
		{
			Name:        "getStockHistory"
			Description: "Get the rollback point (StockHistory)."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query stockHistories {
										stockHistories {
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
			PostScript: "args.stockHistories.collection"
		},
		// 3. Create new stock history based on the current stock summary
		{
			Name:        "createStockHistory"
			Description: "Create a stock summary."
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getStockSummary"
			PreScript: """
							{
								"input": compact({
									"productID": each.productID,
									"totalQuantity": each.totalQuantity,
									"totalCost": each.totalCost,
								})
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation createStockHistory($input: StockHistoryCreateInput!) {
										createStockHistory(input: $input) {
											id
										} 
									}"""
			}
			PostScript: """
							{
								"result": args.createStockHistory.id
							}"""
		},
		// 4. Delete the previous stock history
		{
			Name:        "deleteStockHistory"
			Description: "Delete the stock History."
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.getStockHistory) > 0" // Skip if there is no stock histories to delete
			ForEach:     "context.pipeline.getStockHistory"
			PreScript: """
							{
								"id": each.id
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation deleteStockHistory($id: ID!) {
										deleteStockHistory(id: $id)
									}"""
			}
			PostScript: """
							{
								"result": args.deleteStockHistory
							}"""
		},
	]
}
