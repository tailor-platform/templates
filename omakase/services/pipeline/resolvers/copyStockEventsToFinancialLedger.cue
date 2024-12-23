package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline:settings"
)

copyStockEventsToFinancialLedger: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "copyStockEventsToFinancialLedger"
	Description: """
		    Creates a copy of the operationalStockEvents to financialStockEvents.
		    Only copies the stockEvents which will not be changed anymore and that were not copied yet.
		    
		    Steps:
		    1. Get the operational stock events that are not copied yet and have a closed cost pool
		    2. Create a financial stock event for each operational stock event
		    3. Set the copiedToFinancialLedger flag to true for each operational stock event"""
	Response: {Type: pipeline.String}
	PostScript: """
		    string(size(context.pipeline.getFilteredOperationalStockEvents.result)) + " Record(s) copied"
		"""
	Pipelines: [
		{
			Name:        "recalculateStockEventAndSummary"
			Description: "Recalculate the cost for all the cost pools"
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					mutation {
					    recalculateStockEventAndSummary
					}
					"""
			}
			PostScript: "args.recalculateStockEventAndSummary"
		},
		{
			Name:        "getOldestNotCopiedEventWithOpenCostPool"
			Description: "Get the last created stock event with an open cost pool or an open Receipt."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
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
					                                receipt {
					                                    receiptStatus
					                                }
					                            }
					                        }
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": args.operationalStockEvents.collection.filter(event, 
				                    (
				                        event.receiptLineItem != null 
				                        && event.receiptLineItem.costPools != null 
				                        && size(
				                            event.receiptLineItem.costPools.filter(
				                                costPool, !costPool.costPool.isClosed
				                            )
				                        ) > 0
				                    ) || (
				                        event.receiptLineItem != null 
				                        && event.receiptLineItem.receipt.receiptStatus == "OPEN"
				                    )
				                )
				            }"""
		},
		{
			Name:        "getFilteredOperationalStockEvents"
			Description: "Get the oldest operational stock event with an open cost pool. And get the date."
			Invoker:     settings.adminInvoker
			PreScript: """
				            {
				                "toSequence": size(context.pipeline.getOldestNotCopiedEventWithOpenCostPool.result) > 0 ? 
				                    context.pipeline.getOldestNotCopiedEventWithOpenCostPool.result[0].sequence : 
				                    999999999,
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					                query OperationalStockEvents ($toSequence: Int!){
					                    operationalStockEvents(
					                        query: {
					                            and: {
					                                copiedToFinancialLedger: { eq: false },
					                                sequence: { lt: $toSequence }
					                            }
					                        }
					                        size: 100000
					                    ) {
					                        collection {
					                            id
					                            variantID
					                            incrementalQuantity
					                            unitCost
					                            isOnHold
					                            onHoldQuantity
					                            availableQuantity
					                            totalCost
					                            receiptLineItemID
					                            shipmentLineItemID
					                            createdAt
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
				                "result": args.operationalStockEvents.collection
				            }"""
		},
		{
			Name:        "copyOperationalStockEventsToFinancialStockEvents"
			Description: "Copy the operational stock events to financial stock events."
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getFilteredOperationalStockEvents.result"
			PreScript: """
				            {
				                "input": compact({
				                    "operationalStockEventID": each.id,
				                    "variantID": each.variantID,
				                    "incrementalQuantity": each.incrementalQuantity,
				                    "unitCost": each.unitCost,
				                    "isOnHold": each.isOnHold,
				                    "onHoldQuantity": each.onHoldQuantity,
				                    "availableQuantity": each.availableQuantity,
				                    "totalCost": each.totalCost,
				                    "receiptLineItemID": each.receiptLineItemID,
				                    "shipmentLineItemID": each.shipmentLineItemID
				                })
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					                mutation CreateFinancialStockEvent ($input: FinancialStockEventCreateInput){
					                    createFinancialStockEvent(input: $input){
					                        id
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": args.createFinancialStockEvent.id
				            }"""
		},
		{
			Name:        "updateOperationalStockEvent"
			Description: "Update the operational stock event with the copiedToFinancialLedger flag."
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getFilteredOperationalStockEvents.result"
			PreScript: """
				            {
				                "id": each.id,
				                "input": compact({
				                    "copiedToFinancialLedger": true
				                })
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					                mutation UpdateOperationalStockEvent($id: ID!, $input: OperationalStockEventUpdateInput!){
					                    updateOperationalStockEvent(id: $id, input: $input){
					                        id
					                    }
					                }"""
			}
		},
		{
			Name:        "getFinancialStockSummary"
			Description: "Get the current financial stock summary."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					                query FinancialStockSummary {
					                    financialStockSummaries {
					                        collection {
					                            id
					                            variantID
					                        }
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": args.financialStockSummaries.collection
				            }"""
		},
		{
			Name:        "createOrUpdateFinancialStockSummary"
			Description: "Create or update Financial Stock summary."
			Invoker:     settings.adminInvoker
			PreScript: """
							{
								"input": context.pipeline.getFilteredOperationalStockEvents.result.map(item, {
				                    "id": size(context.pipeline.getFinancialStockSummary.result.filter(summary, summary.variantID == item.variantID)) > 0 ?
				                        context.pipeline.getFinancialStockSummary.result.filter(summary, summary.variantID == item.variantID)[0].id : null,
									"variantID": item.variantID,
									"availableQuantity": item.availableQuantity,
									"onHoldQuantity": item.onHoldQuantity,
									"totalCost": item.totalCost,
								})
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
									mutation bulkUpsertFinancialStockSummary($input: [FinancialStockSummaryCreateInput]!) {
										bulkUpsertFinancialStockSummaries(input: $input)
									}"""
			}
			PostScript: """
							{
								"result": args.bulkUpsertFinancialStockSummaries
							}"""
		},
	]
}
