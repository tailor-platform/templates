package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

calculateStockEventCalc: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "calculateStockEventCalc"
	Description: """
		The purpose of this Pipeline is to create a calculation table for StockEvents.
		This Pipeline follows the following steps:
		1. Get all the StockEvent records. Also in the same query, get all the StockEventCalc records to be deleted in the last step.
		2. Parse and flatten the StockEvent records in pre-script. Then store them in StockEventCalc.
		3. Delete the StockEventCalc records created prior to the step 2.
		"""
	Response: {Type: pipeline.Boolean}
	PostScript: """
		!isNull(context.pipeline.createStockEventCalc.result) || !isNull(context.pipeline.deleteStockEventCalc.result)
		"""
	Pipelines: [
		{
			Name:        "getRecords"
			Description: "Get all the StockEvent records. Also in the same query, get all the StockEventCalc records to be deleted in the last step."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query getRecords {
										stockEvents {
											collection {
												id
												eventDate
												incrementalQuantity
												reason
												lotID
												lot {
													putAway {
														id
														quantity
														putAwayDate
														purchaseOrderID
														purchaseOrder {
															productID
															product {
																sellingStartDate
															}
															locationID
															supplierID
														}
													}
												}
											}
										}
										stockEventCalcs{
											collection{
												id
											}
										}
									}"""
			}
			PostScript: """
							{
								"stockEvents": args.stockEvents,
								"stockEventCalcs": args.stockEventCalcs,
							}"""
		},
		{
			Name:        "createStockEventCalc"
			Description: "Parse and flatten the StockEvent records in pre-script. Then store them in StockEventCalc."
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getRecords.stockEvents.collection"
			PreScript: """
							{
								"stockEventID": each.id,
								"purchaseOrderID": each.lot.putAway.purchaseOrderID,
								"putAwayID": each.lot.putAway.id,
								"productID": each.lot.putAway.purchaseOrder.productID,
								"locationID": each.lot.putAway.purchaseOrder.locationID,
								"lotID": each.lotID,
								"eventDate": each.eventDate,
								"sellingStartDate": each.lot.putAway.purchaseOrder.product.sellingStartDate,
								"incrementalQuantity": each.incrementalQuantity,
								"reason": each.reason,
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation (
									$stockEventID: ID!
									$purchaseOrderID: ID!
									$putAwayID: ID!
									$productID: ID!
									$locationID: ID!
									$lotID: ID!
									$eventDate: Date!
									$sellingStartDate: Date!
									$incrementalQuantity: Int!
									$reason: String!
									) {
										createStockEventCalc(
											input: {
											stockEventID: $stockEventID
											purchaseOrderID: $purchaseOrderID
											putAwayID: $putAwayID
											productID: $productID
											locationID: $locationID
											lotID: $lotID
											eventDate: $eventDate
											sellingStartDate: $sellingStartDate
											incrementalQuantity: $incrementalQuantity
											reason: $reason
											}
										) {
											id
										}
									}"""
			}
			PostScript: """
							{
								"result": args.createStockEventCalc
							}"""
		},
		{
			Name:        "deleteStockEventCalc"
			Description: "Delete the StockEventCalc records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getRecords.stockEventCalcs.collection"
			Test:        "size(context.pipeline.getRecords.stockEventCalcs.collection) > 0" // skip if no records are found
			PreScript: """
				{
					"stockEventCalcID": each.id,
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation deleteStockEventCalc($stockEventCalcID: ID!) {
										deleteStockEventCalc(id: $stockEventCalcID)
									}"""
			}
			PostScript: """
							{
								"result": args.deleteStockEventCalc
							}"""
		},
	]
}
