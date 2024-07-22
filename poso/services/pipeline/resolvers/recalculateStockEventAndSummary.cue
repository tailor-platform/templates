package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

recalculateStockEventAndSummary: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "recalculateStockEventAndSummary"
	Description: """
		The purpose of this Pipeline is to recalculate the StockEvent and StockSummary tables.
		
		This Pipeline follows the following steps
		1. Get the date of the most recent stock history, if there is no stock history, use 2000-01-01T00:00:00Z
		2. Rollback to the rollback point (Stock history)
		3. Get all the StockEvent records after the rollback point
		4. Run calculateStockEventAndUpdateStockSummary for each StockEvent record in step 3
		"""
	Response: {Type: standardPipelineResult}
	PostScript: """
			{
				"result": string(size(context.pipeline.calculateStockEventAndUpdateStockSummary)) + " Record(s) updated",
				"error":  context.pipeline.restoreStockSummaryFromHistory.error + 
				context.pipeline.calculateStockEventAndUpdateStockSummary.map(e, e.error).filter(e, e!="").join(", ")
			}"""
	Pipelines: [
		// 1 Get the date of the most recent stock history, if there is no stock history, use 2000-01-01T00:00:00Z
		{
			Name:        "getMostRecentStockHistoryDate"
			Description: "Get the most recent stock history."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query stockHistories {
										stockHistories {
											collection{
												id
												createdAt
											}
										}
									}"""
			}
			PostScript: """
							{
								"result": args.stockHistories.collection == [] ? '2000-01-01T00:00:00Z' : args.stockHistories.collection[0].createdAt,
							}"""
		},
		// 	2 Rollback to the rollback point (Stock history) 
		{
			Name:        "restoreStockSummaryFromHistory"
			Description: "Delete the stock summary records."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation restoreStockSummaryFromHistory{
										restoreStockSummaryFromHistory{
											result
											error
										}
									}"""
			}
			PostScript: """
							{
								"result": args.restoreStockSummaryFromHistory.result,
								"error": args.restoreStockSummaryFromHistory.error != "" ? "Failed to restore stock summary from history" : ""
							}"""
		},
		// 	3 Get all the StockEvent records after the rollback point
		{
			Name:        "getSortedStockEvents"
			Description: "Get the stock event records."
			Invoker:     settings.adminInvoker
			PreScript: """
							{
								"mostRecentStockHistoryDate": context.pipeline.getMostRecentStockHistoryDate.result
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query stockEvents ($mostRecentStockHistoryDate: DateTime!) {
										stockEvents (query: {createdAt: {gte: $mostRecentStockHistoryDate}}){
											collection{
												id
											}
										}
									}"""
			}
			PostScript: """
							{
								"result": args.stockEvents.collection
							}"""
		},
		// 4. update averageCost, transactionTotalCost, totalCost as null of each StockEvent record in step 3
		{
			Name:        "updateStockEvents"
			Description: "Update the stock summary records."
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.getSortedStockEvents.result) > 0"
			ForEach:     "context.pipeline.getSortedStockEvents.result"
			PreScript: """
							{
								"stockEventID": each.id,
								"averageCost": null,
								"totalQuantity": null,
								"totalCost": null
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation updateStockEvent(
											$stockEventID: ID!, 
											$averageCost: Float, 
											$totalQuantity: Int,
											$totalCost: Float
										) {
										updateStockEvent(
											id: $stockEventID,
											input: {
												averageCost: $averageCost,
												totalQuantity: $totalQuantity,
												totalCost: $totalCost
											}
										){
											id
										}
									}"""
			}
			PostScript: "args.updateStockEvent.id"
		},
		// 	5 Run calculateStockEventAndUpdateStockSummary for each StockEvent record in step 3
		{
			Name:        "calculateStockEventAndUpdateStockSummary"
			Description: "Run calculateStockEventAndUpdateStockSummary pipeline to refresh the StockEvent and StockEventCalc table."
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.getSortedStockEvents.result) > 0"
			ForEach:     "context.pipeline.getSortedStockEvents.result"
			PreScript: """
							{
								"stockEventID": each.id
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation calculateStockEventAndUpdateStockSummary($stockEventID: ID!) {
										calculateStockEventAndUpdateStockSummary(input: { stockEventID: $stockEventID }){
											result
											error
										}
									}"""
			}
			PostScript: """
							{
								"result": args.calculateStockEventAndUpdateStockSummary.result,
								"error": args.calculateStockEventAndUpdateStockSummary.error != "" ? 'Failed to calculate stock event and update stock summary' : ''
							}"""
		},
	]
}
