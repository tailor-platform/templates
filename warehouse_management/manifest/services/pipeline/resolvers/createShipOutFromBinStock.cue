package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

createShipOutFromBinStock: pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure
    Name:        "createShipOutFromBinStock"
    Description: """
    Creating a ShipOutLineItem record, while updating the BinStock record. Used in the picking screens.

    Steps:
    1. Fetch the BinStock record by UUID, provided as the input (binStock)
    2. Check if the quantity, provided as the input equals to or less than the quantity of the BinStock.quantity. Return error and exit if not.
    3. If input.quantity = BinStock.quantity, delete the BinStock record (deleteBinStock)
    4. If input.quantity < BinStock.quantity, update the BinStock.quantity to (BinStock.quantity - input.quantity) (updateBinStock)
    5. Create a ShipOutLineItem record, with input.salesOrderID (createShipOutLineItem)
    """
    Response: { Type: pipeline.Boolean }
    PostScript: "context.pipeline.fetchBinStock.isValid"
    Inputs: [
        {   Name: "input"
            Required: true
            Type: {
                Name: "createShipOutFromBinStockInput"
                Fields: [
                    {Name: "binStockID", Type: pipeline.ID, Required:  true},
                    {Name: "quantity", Type: pipeline.Int, Required:  true},
                    {Name: "salesOrderID", Type: pipeline.ID, Required:  true},
                ]
            }
        },
    ]
    Pipelines: [
        // 1. Fetch the BinStock record by UUID, provided as the input (binStock)
        // 2. Check if the quantity, provided as the input equals to or less than the quantity of the BinStock.quantity. Return error and exit if not.
        {
            Name:        "fetchBinStock"
            Description: "Fetch the BinStock record by UUID, provided as the input (binStock)"

            PreScript: "context.args.input"
            Invoker:     settings.adminInvoker
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query binStock($binStockID: ID!){
                    binStock(id: $binStockID){
                        id
                        binID
                        productID
                        quantity
                    }
                }"""
            }
            PostScript: """
            {
                "result": args.binStock,
                "isValid": !isNull(args.binStock) && (context.args.input.quantity <= args.binStock.quantity)
            }"""
        },
        // 3. If input.quantity = BinStock.quantity, delete the BinStock record (deleteBinStock)
        {
            Name:        "deleteBinStocks"
            Description: "Delete the BinStock record fetched"
            Test: "context.pipeline.fetchBinStock.isValid && context.args.input.quantity == context.pipeline.fetchBinStock.result.quantity" // skip if no records are found
            PreScript: "context.args.input"
            Invoker:     settings.adminInvoker
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
        // 4. If input.quantity < BinStock.quantity, update the BinStock.quantity to (BinStock.quantity - input.quantity) (updateBinStock)
        {
            Name:        "updateBinStock"
            Description: "Update the BinStock record fetched with the new quantity"
            Test:          "context.pipeline.fetchBinStock.isValid && context.args.input.quantity < context.pipeline.fetchBinStock.result.quantity" // skip if no records are found
            PreScript: """
            {
                "binStockID": context.args.input.binStockID,
                "quantity": int(context.pipeline.fetchBinStock.result.quantity) - int(context.args.input.quantity)
            }"""
            Invoker:     settings.adminInvoker
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation updateBinStock($binStockID: ID!, $quantity: Int!) {
                  updateBinStock(id: $binStockID, input: {quantity: $quantity}){
                        id
                  }
                }"""
            }
            PostScript: """
            {
                "result": args.updateBinStock
            }"""
        },
        // 5. Create a ShipOutLineItem record, with input.salesOrderID (createShipOutLineItem)
        {
            Name:        "createShipOut"
            Description: "Create a ShipOut record, with input.salesOrderID"
            Test:          "context.pipeline.fetchBinStock.isValid && context.args.input.quantity < context.pipeline.fetchBinStock.result.quantity" // skip if no records are found
            PreScript: """
            {
                "salesOrderID": context.args.input.salesOrderID,
                "shipOutDate": date(today()),
            }
            """
            Invoker:     settings.adminInvoker
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation createShipOut($salesOrderID: ID!, $shipOutDate: Date!) {
                  createShipOut(input: {salesOrderID: $salesOrderID, shipOutDate: $shipOutDate}){
                        id
                  }
                }"""
            }
            PostScript: """
            {
                "result": args.createShipOut
            }"""
        },
        {
            Name:        "createShipOutLineItem"
            Description: "Create a createShipOutLineItem record, with input.quantity of the BinStock record"
            Test:          "context.pipeline.fetchBinStock.isValid && context.args.input.quantity < context.pipeline.fetchBinStock.result.quantity" // skip if no records are found
            PreScript: """
            {
                "input": compact({
                    "shipOutID": context.pipeline.createShipOut.result.id,
                    "productID": context.pipeline.fetchBinStock.result.productID,
                    "binID": context.pipeline.fetchBinStock.result.binID,
                    "quantity": context.args.input.quantity
                })
            }
            """
            Invoker:     settings.adminInvoker
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation createShipOutLineItem($input: ShipOutLineItemCreateInput!) {
                  createShipOutLineItem(input: $input){
                        id
                  }
                }"""
            }
            PostScript: """
            {
                "result": args.createShipOutLineItem
            }"""
        },
    ]
}
