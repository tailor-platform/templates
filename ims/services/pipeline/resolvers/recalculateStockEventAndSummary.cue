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
	Response: {Type: pipeline.String}
	PostScript: """
			string(size(context.pipeline.getSortedStockEvents.result)) + " Record(s) updated"
		"""
	Pipelines: [
		{
			Name:        "getOldestNotCopiedOperationalStockEvent"
			Description: "Get the oldest operational stock event with an open cost pool."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                query OperationalStockEvents {
					                    operationalStockEvents(
					                        query: {
					                            copiedToFinancialLedger: { eq: false }
					                        }
					                        size: 100000
					                        order: { field: sequence, direction: Asc }
					                    ) {
					                        collection {
					                            sequence
					                            receiptLineItem {
					                                costPools{
					                                    costPool{
					                                        isClosed
					                                    }
					                                }
					                            }
					                        }
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": args.operationalStockEvents.collection.filter(event, 
				                    event.receiptLineItem != null && 
				                    event.receiptLineItem.costPools != null &&
				                    size(
				                        event.receiptLineItem.costPools
				                        .filter(
				                            costPool, 
				                            costPool.costPool.isClosed != null && 
				                            !costPool.costPool.isClosed
				                        )
				                    ) > 0
				                )
				            }"""
		},
		{
			Name:        "getSortedStockEvents"
			Description: "Get the stock event records."
			Invoker:     settings.adminInvoker
			PreScript: """
							{
								"fromSequence": size(context.pipeline.getOldestNotCopiedOperationalStockEvent.result) > 0 ? 
				                    context.pipeline.getOldestNotCopiedOperationalStockEvent.result[0].sequence : 
				                    99999,
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query operationalStockEvents ($fromSequence: Int!) {
										operationalStockEvents (query: {sequence: {gte: $fromSequence}}){
											collection{
												id
												unitCost
					                            receiptLineItem {
					                                totalUnitCost
					                            }
											}
										}
									}"""
			}
			PostScript: """
							{
								"result": args.operationalStockEvents.collection
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
								"unitCost": !isNull(each.receiptLineItem) ? each.receiptLineItem.totalUnitCost : each.unitCost,
								"averageCost": null,
								"onHoldQuantity": null,
								"availableQuantity": null,
								"totalCost": null
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation updateOperationalStockEvent(
											$stockEventID: ID!, 
											$unitCost: Float,
											$averageCost: Float, 
											$onHoldQuantity: Float,
											$availableQuantity: Float,
											$totalCost: Float
										) {
										updateOperationalStockEvent(
											id: $stockEventID,
											input: {
												unitCost: $unitCost,
												averageCost: $averageCost,
												onHoldQuantity: $onHoldQuantity,
												availableQuantity: $availableQuantity,
												totalCost: $totalCost
											}
										){
											id
										}
									}"""
			}
			PostScript: "args.updateOperationalStockEvent.id"
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
										calculateStockEventAndUpdateStockSummary(input: { stockEventID: $stockEventID })
									}"""
			}
			PostScript: """
							{
								"result": args.calculateStockEventAndUpdateStockSummary
							}"""
		},
	]
}
