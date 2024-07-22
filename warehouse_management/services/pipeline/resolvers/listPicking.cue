package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"

)

listPickingResult: {
	Name: "listPickingResult"
	Fields: [
		{
			Name:  "result"
			Array: true
			Type: {
				Name: "listPickingItemResult"
				Fields: [
					{Name: "salesOrderLineItemID", Type: pipeline.ID},
					{Name: "productID", Type: pipeline.ID},
					{Name: "product", Type: {
						Name: "listPickingProductResult"
						Fields: [
							{Name: "brand", Type: pipeline.String},
							{Name: "style", Type: pipeline.String},
							{Name: "code", Type: pipeline.String},
						]
					}},
					{Name: "binStocks", Array: true, Type: {
						Name: "listPickingBinStockResult"
						Fields: [
							{Name: "id", Type: pipeline.ID},
							{Name: "binShelf", Type: pipeline.String},
							{Name: "quantity", Type: pipeline.Int},
						]
					}},
				]}
		},
	]
}

listPicking: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "listPicking"
	Description: """
		Pipeline to list the picking information for a sales order. The pipeline fetches the SalesOrderLineItems with the input.SalesOrderID,
		and then fetches the BinStocks for each product in the SalesOrderLineItems. The result is a list of SalesOrderLineItems, combined
		with the BinStock information that stores the relevant product of the LineItem.

		Steps:
		1. Fetch SalesOrderLineItems with input.SalesOrderID (query salesOrderLineItems)
		2. Get the list of BinID in the warehouse: Query Bins where Bin.warehouseID = input.warehouseID.
		This array will be used as a query parameter in the next step. (query bins)
		3. For each SalesOrderLineItems of the step 1:
		    - Lookup the Product of the current SalesOrderLineItem from BinStock where `BinStock.BinID in [result-of-the-step2]`
		        This gives a list of BinStock that matches with the SalesOrderLineItem.productID in the warehouse specified by
		        input.warehouseID. (query binStocks)
		    - Create an object that has salesOrderLineItem data and BinID, and the BinStock.quantity
		    - Construct a result object that contains the array of SalesOrderLineItem, combined with the BinStock information that stores the relevant product of the LineItem.
		"""
	Response: {Type: listPickingResult}
	PostScript: """
		    {
		        "result": context.pipeline.fetchBinStocks
		    }"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "listPickingInput"
				Fields: [
					{Name: "salesOrderID", Type: pipeline.ID, Required: true},
					{Name: "warehouseID", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Pipelines: [
		//  1. Fetch SalesOrderLineItems with input.SalesOrderID (query salesOrderLineItems)
		{
			Name:        "fetchSalesOrderLineItems"
			Description: "Fetch SalesOrderLineItems with input.SalesOrderID"
			PreScript:   "context.args.input"
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                query salesOrderLineItems($salesOrderID: ID!) {
					                  salesOrderLineItems(query: {salesOrderID: {eq: $salesOrderID}}){
					                    collection{
					                        id
					                        productID
					                        quantity
					                        product{
					                            brand
					                            style
					                            code
					                        }
					                    }
					                  }
					                }"""
			}
			PostScript: "args.salesOrderLineItems.collection"
		},
		// 2. Get the list of BinID in the warehouse: Query Bins where Bin.warehouseID = input.warehouseID. This array will be used as a query parameter in the next step. (query bins)
		{
			Name:        "fetchBins"
			Description: "Get the list of BinID in the warehouse"
			PreScript:   "context.args.input"
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                query bins($warehouseID: ID!) {
					                  bins(query: {warehouseID: {eq: $warehouseID}}){
					                    collection{
					                        id
					                    }
					                  }
					                }"""
			}
			PostScript: """
				            {
				                "binIDs": args.bins.collection.map(e, e.id)
				            }"""
		},
		// 3. For each SalesOrderLineItems of the step 1, query binStock
		{
			Name:        "fetchBinStocks"
			Description: "For each SalesOrderLineItems of the step 1, query binStock"
			ForEach:     "context.pipeline.fetchSalesOrderLineItems"
			PreScript: """
				            {
				                "productID": each.productID,
				                "binIDs": context.pipeline.fetchBins.binIDs
				            }"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                query binStocks($productID: ID!, $binIDs: [ID]) {
					                  binStocks(query: {productID: {eq: $productID}, binID: {in: $binIDs}}){
					                    collection{
					                        id
					                        bin{
					                            shelf
					                        }
					                        quantity
					                    }
					                  }
					                }"""
			}
			PostScript: """
				            {
				                "salesOrderLineItemID": each.id,
				                "productID": each.productID,
				                "product": {
				                    "brand": each.product.brand,
				                    "style": each.product.style,
				                    "code": each.product.code,
				                },
				                "binStocks": args.binStocks.collection.map(e, {
				                    "id": e.id,
				                    "binShelf": e.bin.shelf,
				                    "quantity": e.quantity
				                })
				            }"""
		},
	]
}
