package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

restoreStockSummaryFromHistory: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "restoreStockSummaryFromHistory"
	Description: """
		The purpose of this pipeline is restoring the stock summary from the stock history.
		Used to rollback to a savepoint and recalculate the inventory
		1. Get the most recent stock Summary data
		2. get the most recent Stock history data
		3. Create new stock summary based on the stock history
		4. Delete the previous stock summary
		"""
	Response: {Type: standardPipelineResult}
	PostScript: """
			{
				"result": string(size(context.pipeline.deleteStockSummary)) + " Record(s) updated",
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
		// 3. Create new stock summary based on the stock history
		{
			Name:        "createStockSummary"
			Description: "Create a stock summary."
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getStockHistory"
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
		// 4. Delete the previous stock summary
		{
			Name:        "deleteStockSummary"
			Description: "Delete the stock summary."
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.getStockSummary) > 0" // Skip if there is no stock sumaries to delete
			ForEach:     "context.pipeline.getStockSummary"
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
	]
}
