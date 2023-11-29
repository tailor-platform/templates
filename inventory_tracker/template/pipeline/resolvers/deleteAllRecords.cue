package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

deleteAllRecords: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "deleteAllRecords"
	description: """
	DANGER: Delete all the records in the database. This is a test resolver for development purpose only.
	"""
	response: { type: schema.Boolean }
	postScript: """
	!isNull(context.pipeline.getRecords)
	"""
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "getRecords"
			description: "Get all the records from all the tailordb models."
			url:         settings.services.gateway
			graphqlQuery: """
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
			postScript: """
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
			id: {{generateUUID | quote}}
			name:        "deleteLocation"
			description: "Delete the Location records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.locations.collection"
			test: 		 "size(context.pipeline.getRecords.locations.collection) > 0" // skip if no records are found
			preScript: """
			{
				"locationID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteLocation($locationID: ID!) {
			  deleteLocation(id: $locationID)
			}"""
			postScript: """
			{
				"result": args.deleteLocation
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteProduct"
			description: "Delete the Product records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.products.collection"
			test: 		 "size(context.pipeline.getRecords.products.collection) > 0" // skip if no records are found
			preScript: """
			{
				"productID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteProduct($productID: ID!) {
			  deleteProduct(id: $productID)
			}"""
			postScript: """
			{
				"result": args.deleteProduct
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteSupplier"
			description: "Delete the Supplier records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.suppliers.collection"
			test: 		 "size(context.pipeline.getRecords.suppliers.collection) > 0" // skip if no records are found
			preScript: """
			{
				"supplierID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteSupplier($supplierID: ID!) {
			  deleteSupplier(id: $supplierID)
			}"""
			postScript: """
			{
				"result": args.deleteSupplier
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deletePurchaseOrder"
			description: "Delete the PurchaseOrder records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.purchaseOrders.collection"
			test: 		 "size(context.pipeline.getRecords.purchaseOrders.collection) > 0" // skip if no records are found
			preScript: """
			{
				"purchaseOrderID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deletePurchaseOrder($purchaseOrderID: ID!) {
			  deletePurchaseOrder(id: $purchaseOrderID)
			}"""
			postScript: """
			{
				"result": args.deletePurchaseOrder
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deletePutAway"
			description: "Delete the PutAway records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.putAways.collection"
			test: 		 "size(context.pipeline.getRecords.putAways.collection) > 0" // skip if no records are found
			preScript: """
			{
				"putAwayID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deletePutAway($putAwayID: ID!) {
			  deletePutAway(id: $putAwayID)
			}"""
			postScript: """
			{
				"result": args.deletePutAway
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteLot"
			description: "Delete the Lot records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.lots.collection"
			test: 		 "size(context.pipeline.getRecords.lots.collection) > 0" // skip if no records are found
			preScript: """
			{
				"lotID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteLot($lotID: ID!) {
			  deleteLot(id: $lotID)
			}"""
			postScript: """
			{
				"result": args.deleteLot
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteSalesOrder"
			description: "Delete the SalesOrder records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.salesOrders.collection"
			test: 		 "size(context.pipeline.getRecords.salesOrders.collection) > 0" // skip if no records are found
			preScript: """
			{
				"salesOrderID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteSalesOrder($salesOrderID: ID!) {
			  deleteSalesOrder(id: $salesOrderID)
			}"""
			postScript: """
			{
				"result": args.deleteSalesOrder
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteShipOut"
			description: "Delete the ShipOut records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.shipOuts.collection"
			test: 		 "size(context.pipeline.getRecords.shipOuts.collection) > 0" // skip if no records are found
			preScript: """
			{
				"shipOutID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteShipOut($shipOutID: ID!) {
			  deleteShipOut(id: $shipOutID)
			}"""
			postScript: """
			{
				"result": args.deleteShipOut
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteStockEvent"
			description: "Delete the StockEvent records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.stockEvents.collection"
			test: 		 "size(context.pipeline.getRecords.stockEvents.collection) > 0" // skip if no records are found
			preScript: """
			{
				"stockEventID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteStockEvent($stockEventID: ID!) {
			  deleteStockEvent(id: $stockEventID)
			}"""
			postScript: """
			{
				"result": args.deleteStockEvent
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteStockEventCalc"
			description: "Delete the StockEventCalc records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.stockEventCalcs.collection"
			test: 		 "size(context.pipeline.getRecords.stockEventCalcs.collection) > 0" // skip if no records are found
			preScript: """
			{
				"stockEventCalcID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteStockEventCalc($stockEventCalcID: ID!) {
			  deleteStockEventCalc(id: $stockEventCalcID)
			}"""
			postScript: """
			{
				"result": args.deleteStockEventCalc
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteStockLevel"
			description: "Delete the StockLevel records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.stockLevels.collection"
			test: 		 "size(context.pipeline.getRecords.stockLevels.collection) > 0" // skip if no records are found
			preScript: """
			{
				"stockLevelID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteStockLevel($stockLevelID: ID!) {
			  deleteStockLevel(id: $stockLevelID)
			}"""
			postScript: """
			{
				"result": args.deleteStockLevel
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteSupplierLeadTime"
			description: "Delete the SupplierLeadTime records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.supplierLeadTimes.collection"
			test: 		 "size(context.pipeline.getRecords.supplierLeadTimes.collection) > 0" // skip if no records are found
			preScript: """
			{
				"supplierLeadTimeID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteSupplierLeadTime($supplierLeadTimeID: ID!) {
			  deleteSupplierLeadTime(id: $supplierLeadTimeID)
			}"""
			postScript: """
			{
				"result": args.deleteSupplierLeadTime
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deletePutAwayCalc"
			description: "Delete the PutAwayCalc records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.putAwayCalcs.collection"
			test: 		 "size(context.pipeline.getRecords.putAwayCalcs.collection) > 0" // skip if no records are found
			preScript: """
			{
				"putAwayCalcID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deletePutAwayCalc($putAwayCalcID: ID!) {
			  deletePutAwayCalc(id: $putAwayCalcID)
			}"""
			postScript: """
			{
				"result": args.deletePutAwayCalc
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteDemandForecast"
			description: "Delete the DemandForecast records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.demandForecasts.collection"
			test: 		 "size(context.pipeline.getRecords.demandForecasts.collection) > 0" // skip if no records are found
			preScript: """
			{
				"demandForecastID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteDemandForecast($demandForecastID: ID!) {
			  deleteDemandForecast(id: $demandForecastID)
			}"""
			postScript: """
			{
				"result": args.deleteDemandForecast
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteReplenishmentAlert"
			description: "Delete the ReplenishmentAlert records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.replenishmentAlerts.collection"
			test: 		 "size(context.pipeline.getRecords.replenishmentAlerts.collection) > 0" // skip if no records are found
			preScript: """
			{
				"replenishmentAlertID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteReplenishmentAlert($replenishmentAlertID: ID!) {
			  deleteReplenishmentAlert(id: $replenishmentAlertID)
			}"""
			postScript: """
			{
				"result": args.deleteReplenishmentAlert
			}"""
		},
	]
}
