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
									edges {
										node {
											id
										}
									}
							}
							binStockChanges{
									edges {
										node {
											id
										}
									}
							}
							products{
									edges {
										node {
											id
										}
									}
							}
							stores{
									edges {
										node {
											id
										}
									}
							}
							suppliers{
									edges {
										node {
											id
										}
									}
							}
							warehouses{
									edges {
										node {
											id
										}
									}
							}
							purchaseOrders{
									edges {
										node {
											id
										}
									}
							}
							purchaseOrderLineItems{
									edges {
										node {
											id
										}
									}
							}
							salesOrders{
									edges {
										node {
											id
										}
									}
							}
							salesOrderLineItems{
									edges {
										node {
											id
										}
									}
							}
							shipOuts{
									edges {
										node {
											id
										}
									}
							}
							shipOutLineItems{
									edges {
										node {
											id
										}
									}
							}
							pickingLists{
								edges {
									node {
										id
									}
								}
							}
							pickingListLineItems{
								edges {
									node {
										id
									}
								}
							}
					}"""
			}
			PostScript: """
				{
					"bins": args.bins,
					"binStockChanges": args.binStockChanges,
					"products": args.products,
					"stores": args.stores,
					"suppliers": args.suppliers,
					"warehouses": args.warehouses,
					"purchaseOrders": args.purchaseOrders,
					"purchaseOrderLineItems": args.purchaseOrderLineItems,
					"salesOrders": args.salesOrders,
					"salesOrderLineItems": args.salesOrderLineItems,
					"shipOuts": args.shipOuts,
					"shipOutLineItems": args.shipOutLineItems,
					"pickingLists": args.pickingLists,
					"pickingListLineItems": args.pickingListLineItems,
				}"""
		},
		{
			Name:        "deleteBins"
			Description: "Delete the Bin records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.bins.edges"
			Test:        "size(context.pipeline.getRecords.bins.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"binID": each.node.id,
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
			Name:        "deleteBinStockChanges"
			Description: "Delete the BinStock records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.binStockChanges.edges"
			Test:        "size(context.pipeline.getRecords.binStockChanges.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"binStockChangeID": each.node.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation deleteBinStockChange($binStockChangeID: ID!) {
						deleteBinStockChange(id: $binStockChangeID)
					}"""
			}
			PostScript: """
				{
					"result": args.deleteBinStockChange
				}"""
		},
		{
			Name:        "deleteProducts"
			Description: "Delete the Product records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.products.edges"
			Test:        "size(context.pipeline.getRecords.products.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"productID": each.node.id,
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
			ForEach:     "context.pipeline.getRecords.stores.edges"
			Test:        "size(context.pipeline.getRecords.stores.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"storeID": each.node.id,
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
			ForEach:     "context.pipeline.getRecords.suppliers.edges"
			Test:        "size(context.pipeline.getRecords.suppliers.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"supplierID": each.node.id,
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
			ForEach:     "context.pipeline.getRecords.warehouses.edges"
			Test:        "size(context.pipeline.getRecords.warehouses.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"warehouseID": each.node.id,
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
			ForEach:     "context.pipeline.getRecords.purchaseOrders.edges"
			Test:        "size(context.pipeline.getRecords.purchaseOrders.edges) > 0" // skip if no records are found
			PreScript: """
				{
				  "purchaseOrderID": each.node.id,
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
			ForEach:     "context.pipeline.getRecords.purchaseOrderLineItems.edges"
			Test:        "size(context.pipeline.getRecords.purchaseOrderLineItems.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"purchaseOrderLineItemID": each.node.id,
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
			Name:        "deleteSalesOrders"
			Description: "Delete the SalesOrder records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.salesOrders.edges"
			Test:        "size(context.pipeline.getRecords.salesOrders.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"salesOrderID": each.node.id,
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
			ForEach:     "context.pipeline.getRecords.salesOrderLineItems.edges"
			Test:        "size(context.pipeline.getRecords.salesOrderLineItems.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"salesOrderLineItemID": each.node.id,
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
			ForEach:     "context.pipeline.getRecords.shipOuts.edges"
			Test:        "size(context.pipeline.getRecords.shipOuts.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"shipOutID": each.node.id,
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
			ForEach:     "context.pipeline.getRecords.shipOutLineItems.edges"
			Test:        "size(context.pipeline.getRecords.shipOutLineItems.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"shipOutLineItemID": each.node.id,
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
		{
			Name:        "deletePickingLists"
			Description: "Delete the PickingList records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.pickingLists.edges"
			Test:        "size(context.pipeline.getRecords.pickingLists.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"pickingListID": each.node.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation deletePickingList($pickingListID: ID!) {
							deletePickingList(id: $pickingListID)
					}"""
			}
			PostScript: """
				{
					"result": args.deletePickingList
				}"""
		},
		{
			Name:        "deletePickingListLineItems"
			Description: "Delete the PickingListLineItem records fetched in the step 1"
			ForEach:     "context.pipeline.getRecords.pickingListLineItems.edges"
			Test:        "size(context.pipeline.getRecords.pickingListLineItems.edges) > 0" // skip if no records are found
			PreScript: """
				{
					"pickingListLineItemID": each.node.id,
				}
				"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation deletePickingListLineItem($pickingListLineItemID: ID!) {
							deletePickingListLineItem(id: $pickingListLineItemID)
					}"""
			}
			PostScript: """
				{
						"result": args.deletePickingListLineItem
				}"""
		}
	]
}
