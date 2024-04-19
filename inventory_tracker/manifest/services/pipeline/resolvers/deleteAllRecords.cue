package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

deleteAllRecords: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "deleteAllRecords"
	Description: """
	DANGER: Delete all the records in the database. This is a test resolver for development purpose only.
	"""
	Response: { Type: pipeline.Boolean }
	PostScript: """
	!isNull(context.pipeline.getRecords)
	"""
	Pipelines: [
		{
	
			Name:        "getRecords"
			Description: "Get all the records from all the tailordb models."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query getRecords {
					locations{
						collection{
							id
						}
					}
					products{
						collection{
							id
						}
					}
					suppliers{
						collection{
							id
						}
					}
					purchaseOrders{
						collection{
							id
						}
					}
					putAways{
						collection{
							id
						}
					}
					lots{
						collection{
							id
						}
					}
					salesOrders{
						collection{
							id
						}
					}
					shipOuts{
						collection{
							id
						}
					}
					stockEvents {
						collection {
							id
						}
					}
					stockEventCalcs{
						collection{
							id
						}
					}
					stockLevels{
						collection{
							id
						}
					}
					supplierLeadTimes{
						collection{
							id
						}
					}
					putAwayCalcs{
						collection{
							id
						}
					}
					demandForecasts{
						collection{
							id
						}
					}
					replenishmentAlerts{
						collection{
							id
						}
					}
				}"""
			}
			PostScript: """
			{
				"locations": args.locations,
				"products": args.products,
				"suppliers": args.suppliers,
				"purchaseOrders": args.purchaseOrders,
				"putAways": args.putAways,
				"lots": args.lots,
				"salesOrders": args.salesOrders,
				"shipOuts": args.shipOuts,
				"stockEvents": args.stockEvents,
				"stockEventCalcs": args.stockEventCalcs,
				"stockLevels": args.stockLevels,
				"supplierLeadTimes": args.supplierLeadTimes,
				"putAwayCalcs": args.putAwayCalcs,
				"demandForecasts": args.demandForecasts,
				"replenishmentAlerts": args.replenishmentAlerts,
			}"""
		},
		{
			Name:        "deleteLocation"
			Description: "Delete the Location records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.locations.collection"
			Test: 		 "size(context.pipeline.getRecords.locations.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"locationID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteLocation($locationID: ID!) {
			  		deleteLocation(id: $locationID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteLocation
			}"""
		},
		{
			Name:        "deleteProduct"
			Description: "Delete the Product records created prior to the step 2"
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
			Name:        "deleteSupplier"
			Description: "Delete the Supplier records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.suppliers.collection"
			Test: 		 "size(context.pipeline.getRecords.suppliers.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"supplierID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteSupplier($supplierID: ID!) {
			  		deleteSupplier(id: $supplierID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteSupplier
			}"""
		},
		{
			Name:        "deletePurchaseOrder"
			Description: "Delete the PurchaseOrder records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.purchaseOrders.collection"
			Test: 		 "size(context.pipeline.getRecords.purchaseOrders.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"purchaseOrderID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deletePurchaseOrder($purchaseOrderID: ID!) {
			  		deletePurchaseOrder(id: $purchaseOrderID)
				}"""
			}
			PostScript: """
			{
				"result": args.deletePurchaseOrder
			}"""
		},
		{
			Name:        "deletePutAway"
			Description: "Delete the PutAway records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.putAways.collection"
			Test: 		 "size(context.pipeline.getRecords.putAways.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"putAwayID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deletePutAway($putAwayID: ID!) {
			  		deletePutAway(id: $putAwayID)
				}"""
			}
			PostScript: """
			{
				"result": args.deletePutAway
			}"""
		},
		{
			Name:        "deleteLot"
			Description: "Delete the Lot records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.lots.collection"
			Test: 		 "size(context.pipeline.getRecords.lots.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"lotID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteLot($lotID: ID!) {
			  		deleteLot(id: $lotID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteLot
			}"""
		},
		{
			Name:        "deleteSalesOrder"
			Description: "Delete the SalesOrder records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.salesOrders.collection"
			Test: 		 "size(context.pipeline.getRecords.salesOrders.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"salesOrderID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteSalesOrder($salesOrderID: ID!) {
			  		deleteSalesOrder(id: $salesOrderID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteSalesOrder
			}"""
		},
		{
			Name:        "deleteShipOut"
			Description: "Delete the ShipOut records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.shipOuts.collection"
			Test: 		 "size(context.pipeline.getRecords.shipOuts.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"shipOutID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteShipOut($shipOutID: ID!) {
			  		deleteShipOut(id: $shipOutID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteShipOut
			}"""
		},
		{
			Name:        "deleteStockEvent"
			Description: "Delete the StockEvent records created prior to the step 2"
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
			Name:        "deleteStockEventCalc"
			Description: "Delete the StockEventCalc records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.stockEventCalcs.collection"
			Test: 		 "size(context.pipeline.getRecords.stockEventCalcs.collection) > 0" // skip if no records are found
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
		{
			Name:        "deleteStockLevel"
			Description: "Delete the StockLevel records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.stockLevels.collection"
			Test: 		 "size(context.pipeline.getRecords.stockLevels.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"stockLevelID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteStockLevel($stockLevelID: ID!) {
			  		deleteStockLevel(id: $stockLevelID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteStockLevel
			}"""
		},
		{
			Name:        "deleteSupplierLeadTime"
			Description: "Delete the SupplierLeadTime records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.supplierLeadTimes.collection"
			Test: 		 "size(context.pipeline.getRecords.supplierLeadTimes.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"supplierLeadTimeID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteSupplierLeadTime($supplierLeadTimeID: ID!) {
			  		deleteSupplierLeadTime(id: $supplierLeadTimeID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteSupplierLeadTime
			}"""
		},
		{
			Name:        "deletePutAwayCalc"
			Description: "Delete the PutAwayCalc records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.putAwayCalcs.collection"
			Test: 		 "size(context.pipeline.getRecords.putAwayCalcs.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"putAwayCalcID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deletePutAwayCalc($putAwayCalcID: ID!) {
			  		deletePutAwayCalc(id: $putAwayCalcID)
				}"""
			}
			PostScript: """
			{
				"result": args.deletePutAwayCalc
			}"""
		},
		{
			Name:        "deleteDemandForecast"
			Description: "Delete the DemandForecast records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.demandForecasts.collection"
			Test: 		 "size(context.pipeline.getRecords.demandForecasts.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"demandForecastID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteDemandForecast($demandForecastID: ID!) {
			  		deleteDemandForecast(id: $demandForecastID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteDemandForecast
			}"""
		},
		{
			Name:        "deleteReplenishmentAlert"
			Description: "Delete the ReplenishmentAlert records created prior to the step 2"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.replenishmentAlerts.collection"
			Test: 		 "size(context.pipeline.getRecords.replenishmentAlerts.collection) > 0" // skip if no records are found
			PreScript: """
			{
				"replenishmentAlertID": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteReplenishmentAlert($replenishmentAlertID: ID!) {
			  		deleteReplenishmentAlert(id: $replenishmentAlertID)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteReplenishmentAlert
			}"""
		},
	]
}
