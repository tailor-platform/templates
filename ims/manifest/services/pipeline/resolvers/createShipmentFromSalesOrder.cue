package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

createShipmentFromSalesOrder: pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure
    Name:        "createShipmentFromSalesOrder"
    Description: """
    This pipeline creates a shipment from a sales order. Also copies the line items from the sales order to the shipment.
    Steps:  
    1. Fetch the sales order and its line items
    2. Create a shipment and get the ID
    3. bulk create the shipment line items
    """
    Inputs: [
        {Name: "input"
            Required: true
            Type: {
                Name: "createShipmentFromSalesOrderInput"
                Fields: [
                    {Name: "salesOrderID", Type: pipeline.ID, Required:  true},
                    {Name: "markAsShipped", Type: pipeline.Boolean, Required:  false},
                ]
            }
        },
    ]
    Response: { Type: pipeline.String }
    PostScript: "context.pipeline.createShipment.id"
    Pipelines: [
        {
            Name:        "fetchSalesOrder"
            Description: "Fetch all the line items of the sales order"
            Invoker:     settings.adminInvoker
            PreScript: "context.args.input"
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query  ( $salesOrderID: ID!) {
                    salesOrder(id: $salesOrderID) {
                        id
                        orderNumber
                        customerID
                    }
                    salesOrderLineItems(query: {salesOrderID: {eq: $salesOrderID}}) {
                        collection {
                            id
                            variantID
                            quantity
                            unitPrice
                            taxable
                        }
                    }
                    stockSummaries{
                        collection{
                            id
                            variantID
                            averageCost
                        }
                    }
                }"""
            }
            PostScript: """
            {
                "salesOrder": args.salesOrder,
                "salesOrderLineItems": args.salesOrderLineItems.collection.map(item, {
                    "id": item.id,
                    "variantID": item.variantID,
                    "quantity": item.quantity,
                    "taxable": item.taxable,
                    "unitPrice": item.unitPrice,
                    "unitCost": size(args.stockSummaries.collection.filter(ss, ss.variantID == item.variantID)) > 0 ? 
                        decimal(args.stockSummaries.collection.filter(ss, ss.variantID == item.variantID)[0].averageCost) : 
                        decimal(0.0)
                }),
            }"""
            PostValidation: """
            isNull(context.pipeline.fetchSalesOrder.salesOrder) ? 
            "Sales Order not found" : 
            ""
            """
        },
        {
            Name:        "createShipment"
            Description: "Create a shipment from the sales order"
            Invoker:     settings.adminInvoker
            PreScript:   """
            {
                "input": {
                    "salesOrderID": context.pipeline.fetchSalesOrder.salesOrder.id,
                    "customerID": context.pipeline.fetchSalesOrder.salesOrder.customerID,
                    "shipmentNumber": "Shipment - SO" + string(context.pipeline.fetchSalesOrder.salesOrder.orderNumber),
                }
            }
            """
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation ($input: ShipmentCreateInput!) {
                    createShipment(input: $input) {
                        id
                    }
                }
                """
            }
            PostScript: "args.createShipment"
        },
        {
            Name:       "createShipmentLineItems"
            Description: "Create shipment line items from the sales order line items"
            Invoker:    settings.adminInvoker
            Test: "size(context.pipeline.fetchSalesOrder.salesOrderLineItems) > 0"
            PreScript:  """
            {
                "input": context.pipeline.fetchSalesOrder.salesOrderLineItems.map(item, {
                    "shipmentID": context.pipeline.createShipment.id,
                    "variantID": item.variantID,
                    "quantity": item.quantity,
                    "taxable": item.taxable,
                    "unitCost": item.unitCost,
                    "unitPrice": item.unitPrice,
                    "shipmentStatus": "DRAFT"
                })
            }
            """
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation ($input: [ShipmentLineItemCreateInput]) {
                    bulkUpsertShipmentLineItems(input: $input)
                }
                """
            }
            PostScript: "args.bulkUpsertShipmentLineItems"
        },
        {
            Name: "getShipmentLineItems"
            Description: "Get the lineItems of the shipment if the we want to mark the shipment as shipped"
            Invoker: settings.adminInvoker
            Test: "context.args.input.markAsShipped == true"
            PreScript: """
            {
                "shipmentID": context.pipeline.createShipment.id
            }
            """
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query ($shipmentID: ID!) {
                    shipmentLineItems(query: {shipmentID: {eq: $shipmentID}}) {
                        collection {
                            id
                        }
                    }
                }
                """
            }
            PostScript: "args.shipmentLineItems.collection"
        },
        {
            Name: "holdShipment"
            Description: "Hold the shipment if markAsShipped is true"
            Invoker: settings.adminInvoker
            Test: "context.args.input.markAsShipped == true"
            PreScript: """
            {
                "shipmentItemIDs": context.pipeline.getShipmentLineItems.map(item, item.id)
            }
            """
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation ($shipmentItemIDs: [ID]!) {
                    createStockEventsFromShipmentLineItems(
                        input: {
                        shipmentItemIDs: $shipmentItemIDs
                        action: HOLD
                        }
                    )
                    }
                """
            }
        },
        {
            Name: "shipShipment"
            Description: "Hold the shipment if markAsShipped is true"
            Invoker: settings.adminInvoker
            Test: "context.args.input.markAsShipped == true"
            PreScript: """
            {
                "shipmentItemIDs": context.pipeline.getShipmentLineItems.map(item, item.id)
            }
            """
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation ($shipmentItemIDs: [ID]!) {
                    createStockEventsFromShipmentLineItems(
                        input: {
                        shipmentItemIDs: $shipmentItemIDs
                        action: SHIP
                        }
                    )
                    }
                """
            }
        }
    ]
}
