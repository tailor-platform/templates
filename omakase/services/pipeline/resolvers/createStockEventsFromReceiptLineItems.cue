package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/environment"
    "tailor.build/template/services/pipeline:settings"
)

createStockEventsFromReceiptLineItems: pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure
    Name:          "createStockEventsFromReceiptLineItems"
    Description: """
        Create StockEvent records from the ReceiptLineItem records.
        Steps

        1. Get the ReceiptLineItem records
        
        Verify that the creation is allowed. To do this:
        2. If the status is "RECEIVED", throw an error. Because the stock event was already created.
        3. Only create stock events for "INVENTORY" products (filter the ReceiptLineItem records by product type)
        4. Create a StockEvent record for each ReceiptLineItem record
        5. run calculateStockEventAndUpdateStockSummary pipeline to refresh the StockEvent and StockEventCalc table.
        6. Change the status of the ReceiptLineItem record to "RECEIVED"
        """
    Response: {Type: {
        Name: "createStockEventsFromReceiptLineItemsOutput"
        Fields: [
            {
                Name:  "stockEventIDs"
                Type:  pipeline.ID
                Array: true
            }]
    }}
    PostScript: """
        {
            "stockEventIDs": context.pipeline.createOperationStockEvents
        }
        """
    Inputs: [
        {Name: "input"
            Required: true
            Type: {
                Name: "createStockEventsFromReceiptLineItemsInput"
                Fields: [
                    {
                        Name:     "receiptLineItemIDs"
                        Type:     pipeline.ID
                        Required: true
                        Array:    true
                    },
                ]
            }
        },
    ]
    Pipelines: [
        {
            Name:        "getReceiptLineItems"
            Description: "Get the stock event records."
            Invoker:     settings.adminInvoker
            PreScript: """
                            {
                                "ids": context.args.input.receiptLineItemIDs
                            }"""
            Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
                Query: """
query ($ids: [ID]) {
  receiptLineItems(query: {id: {in: $ids}}) {
    edges {
      node {
        id
        variantID
        quantity
        receiptStatus
        totalUnitCost
        variant {
          inventoryType
        }
      }
    }
  }
}"""
            }
            PostScript: "args.receiptLineItems.edges"
        },
        {
            Name:        "validateReceiptLineItemStatus"
            Description: "Validate the status of the ReceiptLineItem records."
            Invoker:     settings.adminInvoker
            PostValidation: """
                size(context.pipeline.getReceiptLineItems.filter(rli, rli.node.receiptStatus == 'RECEIVED')) > 0 ?
                "Unable to create stock events because some of the receipt lines are already received" : ""
                """
        },
        {
            Name:        "createOperationStockEvents"
            Description: "Create StockEvent records from the ReceiptLineItem records."
            Invoker:     settings.adminInvoker
            ForEach:     "context.pipeline.getReceiptLineItems.filter(rli, rli.node.variant.inventoryType == 'INVENTORY')"
            PreScript: """
                            {
                                "input": {
                                    "variantID": each.node.variantID,
                                    "isOnHold": false,
                                    "incrementalQuantity": each.node.quantity,
                                    "unitCost": each.node.totalUnitCost,
                                    "receiptLineItemID": each.node.id
                                }
                            }"""
            Operation: pipeline.#GraphqlOperation & {
                AppName: environment.#app.namespace
                Query: """
                                    mutation ($input: OperationalStockEventCreateInput!) {
                                        createOperationalStockEvent(input: $input){
                                            id
                                        }
                                    }"""
            }
            PostScript: "args.createOperationalStockEvent.id"
        },
        {
            Name:        "runCalculateStockEventAndUpdateStockSummary"
            Description: "Run calculateStockEventAndUpdateStockSummary pipeline to refresh the StockEvent and StockEventCalc table."
            Invoker:     settings.adminInvoker
            ForEach:     "context.pipeline.createOperationStockEvents"
            PreScript: """
                            {
                                "input": {
                                    "stockEventID": each
                                }
                            }"""
            Operation: pipeline.#GraphqlOperation & {
                AppName: environment.#app.namespace
                Query: """
                                    mutation ($input: calculateStockEventAndUpdateStockSummaryInput!) {
                                        calculateStockEventAndUpdateStockSummary(input: $input)
                                    }"""
            }
            PostScript: "args.calculateStockEventAndUpdateStockSummary"
        },
        {
            Name:        "updateReceiptLineItemStatus"
            Description: "Change the status of the ReceiptLineItem record to 'RECEIVED'."
            Invoker:     settings.adminInvoker
            ForEach:     "context.pipeline.getReceiptLineItems"
            PreScript: """
                            {
                                "id": each.node.id,
                                "input": compact({
                                    "receiptStatus": "RECEIVED"
                                })
                            }"""
            Operation: pipeline.#GraphqlOperation & {
                AppName: environment.#app.namespace
                Query: """
                                    mutation ($id: ID!, $input: ReceiptLineItemUpdateInput!) {
                                        updateReceiptLineItem(id: $id, input: $input){
                                            id
                                        }
                                    }"""
            }
            PostScript: "args.updateReceiptLineItem.id"
        },
    ]
}
