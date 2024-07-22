package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"

)

deleteAllTailorDBRecords: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "deleteAllTailorDBRecords"
	Description: """
		DANGER: Delete all the records in the database. This is a resolver for development purpose only.
		"""
	Response: {Type: pipeline.Boolean}
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
					                    bins{
					                        collection {
					                            id
					                        }
					                    }
					                    binStocks{
					                        collection {
					                            id
					                        }
					                    }
					                    products{
					                        collection {
					                            id
					                        }
					                    }
					                    stores{
					                        collection {
					                            id
					                        }
					                    }
					                    suppliers{
					                        collection {
					                            id
					                        }
					                    }
					                    warehouses{
					                        collection {
					                            id
					                        }
					                    }
					                    purchaseOrders{
					                        collection {
					                            id
					                        }
					                    }
					                    purchaseOrderLineItems{
					                        collection {
					                            id
					                        }
					                    }
					                    putAways{
					                        collection {
					                            id
					                        }
					                    }
					                    putAwayLineItems{
					                        collection {
					                            id
					                        }
					                    }
					                    salesOrders{
					                        collection {
					                            id
					                        }
					                    }
					                    salesOrderLineItems{
					                        collection {
					                            id
					                        }
					                    }
					                    shipOuts{
					                        collection {
					                            id
					                        }
					                    }
					                    shipOutLineItems{
					                        collection {
					                            id
					                        }
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "bins": args.bins,
				                "binStocks": args.binStocks,
				                "products": args.products,
				                "stores": args.stores,
				                "suppliers": args.suppliers,
				                "warehouses": args.warehouses,
				                "purchaseOrders": args.purchaseOrders,
				                "purchaseOrderLineItems": args.purchaseOrderLineItems,
				                "putAways": args.putAways,
				                "putAwayLineItems": args.putAwayLineItems,
				                "salesOrders": args.salesOrders,
				                "salesOrderLineItems": args.salesOrderLineItems,
				                "shipOuts": args.shipOuts,
				                "shipOutLineItems": args.shipOutLineItems,
				            }"""
		},
		{
			Name:        "deleteBins"
			Description: "Delete the Bin records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.bins.collection"
			Test:        "size(context.pipeline.getRecords.bins.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "binID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deleteBin($binID: ID!) {
					                    deleteBin(id: $binID)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deleteBin
				            }"""
		},
		{
			Name:        "deleteBinStocks"
			Description: "Delete the BinStock records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.binStocks.collection"
			Test:        "size(context.pipeline.getRecords.binStocks.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "binStockID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deleteBinStock($binStockID: ID!) {
					                    deleteBinStock(id: $binStockID)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deleteBinStock
				            }"""
		},
		{
			Name:        "deleteProducts"
			Description: "Delete the Product records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.products.collection"
			Test:        "size(context.pipeline.getRecords.products.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "productID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
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
			Name:        "deleteStores"
			Description: "Delete the Store records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.stores.collection"
			Test:        "size(context.pipeline.getRecords.stores.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "storeID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deleteStore($storeID: ID!) {
					                    deleteStore(id: $storeID)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deleteStore
				            }"""
		},
		{
			Name:        "deleteSuppliers"
			Description: "Delete the Supplier records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.suppliers.collection"
			Test:        "size(context.pipeline.getRecords.suppliers.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "supplierID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
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
			Name:        "deleteWarehouses"
			Description: "Delete the Warehouse records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.warehouses.collection"
			Test:        "size(context.pipeline.getRecords.warehouses.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "warehouseID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deleteWarehouse($warehouseID: ID!) {
					                    deleteWarehouse(id: $warehouseID)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deleteWarehouse
				            }"""
		},
		{
			Name:        "deletePurchaseOrders"
			Description: "Delete the PurchaseOrder records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.purchaseOrders.collection"
			Test:        "size(context.pipeline.getRecords.purchaseOrders.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "purchaseOrderID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
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
			Name:        "deletePurchaseOrderLineItems"
			Description: "Delete the PurchaseOrderLineItem records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.purchaseOrderLineItems.collection"
			Test:        "size(context.pipeline.getRecords.purchaseOrderLineItems.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "purchaseOrderLineItemID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deletePurchaseOrderLineItem($purchaseOrderLineItemID: ID!) {
					                    deletePurchaseOrderLineItem(id: $purchaseOrderLineItemID)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deletePurchaseOrderLineItem
				            }"""
		},
		{
			Name:        "deletePutAways"
			Description: "Delete the PutAway records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.putAways.collection"
			Test:        "size(context.pipeline.getRecords.putAways.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "putAwayID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
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
			Name:        "deletePutAwayLineItems"
			Description: "Delete the PutAwayLineItem records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.putAwayLineItems.collection"
			Test:        "size(context.pipeline.getRecords.putAwayLineItems.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "putAwayLineItemID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deletePutAwayLineItem($putAwayLineItemID: ID!) {
					                deletePutAwayLineItem(id: $putAwayLineItemID)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deletePutAwayLineItem
				            }"""
		},
		{
			Name:        "deleteSalesOrders"
			Description: "Delete the SalesOrder records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.salesOrders.collection"
			Test:        "size(context.pipeline.getRecords.salesOrders.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "salesOrderID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
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
			Name:        "deleteSalesOrderLineItems"
			Description: "Delete the SalesOrderLineItem records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.salesOrderLineItems.collection"
			Test:        "size(context.pipeline.getRecords.salesOrderLineItems.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "salesOrderLineItemID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deleteSalesOrderLineItem($salesOrderLineItemID: ID!) {
					                    deleteSalesOrderLineItem(id: $salesOrderLineItemID)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deleteSalesOrderLineItem
				            }"""
		},
		{
			Name:        "deleteShipOuts"
			Description: "Delete the ShipOut records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.shipOuts.collection"
			Test:        "size(context.pipeline.getRecords.shipOuts.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "shipOutID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
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
			Name:        "deleteShipOutLineItems"
			Description: "Delete the ShipOutLineItem records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.shipOutLineItems.collection"
			Test:        "size(context.pipeline.getRecords.shipOutLineItems.collection) > 0" // skip if no records are found
			PreScript: """
				{
				    "shipOutLineItemID": each.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deleteShipOutLineItem($shipOutLineItemID: ID!) {
					                    deleteShipOutLineItem(id: $shipOutLineItemID)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deleteShipOutLineItem
				            }"""
		},
	]
}
