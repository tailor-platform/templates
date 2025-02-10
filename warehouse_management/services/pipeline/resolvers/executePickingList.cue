package resolvers

import(
  "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
  "tailor.build/template/services/pipeline:settings"
)

executePickingList: pipeline.#Resolver & {
  Name: "executePickingList"
  Description: "Execute PickingList"
  Response: {
    Type: pipeline.Boolean
  }
  PostScript: """
    !isNull(context.pipeline.executePickingList)
  """
  Inputs: [
    {
      Name: "input"
      Required: true
      Type: {
        Name: "ExecutePickingListInput",
        Fields: [
          { Name: "pickingListID", Type: pipeline.ID, Required: true },
        ]
      }
    },
  ]
  Pipelines: [
    {
      Name: "fetchPickingList"
      Description: "Fetch the Pickup record by UUID, provided as the input (pickingListID)"
      PreScript: "context.args.input"
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          query pickingList($pickingListID: ID!){
            pickingList(id: $pickingListID){
              id
              salesOrderID
              pickingListDate
            }
          }"""
      }
      PostScript: """
        args.pickingList
      """
    },
    {
      Name: "fetchPickingListLineItems"
      Description: "Fetch the PickingListLineItems records by PickingList ID, provided as the input (pickingListID)"
      PreScript: "context.args.input"
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          query pickingListLineItems($pickingListID: ID!){
            pickingListLineItems(query: {pickingListID: {eq: $pickingListID}}){
              edges {
                node {
                  id
                  productID
                  quantity
                  binID
                  warehouseID
                  salesOrderLineItemID
                }
              }
            }
          }"""
      }
      PostScript: """
        args.pickingListLineItems.edges
      """
    },
    {
      Name: "updateStock"
      Description: "Update the stock"
      Invoker: settings.adminInvoker
      ForEach: "context.pipeline.fetchPickingListLineItems"
      PreScript: """
        {
          "productID": each.node.productID,
          "quantity": -each.node.quantity,
          "binID": each.node.binID,
          "warehouseID": each.node.warehouseID,
          "sourceID": context.args.input.pickingListID,
          "sourceType": "PickingList"
        }"""
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation updateStock($productID: ID!, $quantity: Int!, $binID: ID!, $warehouseID: ID!, $sourceID: ID!, $sourceType: String!){
            createBinStockChange(input: {
              productID: $productID,
              quantity: $quantity,
              binID: $binID,
              warehouseID: $warehouseID,
              sourceID: $sourceID,
              sourceType: $sourceType
            }) {
    					id
  					}
          }"""
      }
      PostScript: "args.createBinStockChange"
    },
    {
      Name: "createShipOut"
      Description: "Create a ShipOut record"
      PreScript: """
      {
        "pickingListID": context.args.input.pickingListID,
        "salesOrderID": context.pipeline.fetchPickingList.salesOrderID,
        "shipOutDate": context.pipeline.fetchPickingList.pickingListDate
      }"""
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation createShipOut($pickingListID: ID!, $salesOrderID: ID!, $shipOutDate: Date!){
            createShipOut(input: {
              pickingListID: $pickingListID,
              salesOrderID: $salesOrderID,
              shipOutDate: $shipOutDate
            }) {
              id
            }
          }"""
      }
      PostScript: "args.createShipOut"
    },
    {
      Name: "createShipOutLineItems"
      Description: "Create ShipOutLineItem records"
      Invoker: settings.adminInvoker
      ForEach: "context.pipeline.fetchPickingListLineItems"
      PreScript: """
      {
        "input": {
          "shipOutID": context.pipeline.createShipOut.id,
          "pickingListLineItemID": each.node.id,
          "salesOrderLineItemID": each.node.salesOrderLineItemID,
          "productID": each.node.productID,
          "quantity": each.node.quantity
        }
      }"""
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation createShipOutLineItem($input: ShipOutLineItemCreateInput!) {
            createShipOutLineItem(input: $input){
              id
            }
          }"""
      }
      PostScript: "args.createShipOutLineItem"
    },
    {
      Name: "updatePickingListAndSalesOrder"
      Description: "Update the PickingList record by ID, provided as the input (pickingListID)"
      PreScript: """
      {
        "pickingListID": context.args.input.pickingListID,
        "salesOrderID": context.pipeline.fetchPickingList.salesOrderID
      }"""
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation finishReceiving($pickingListID: ID!, $salesOrderID: ID!) {
            updatePickingList(id: $pickingListID, input: {
              status: "complete"
            }) {
              id
            }
            updateSalesOrder(id: $salesOrderID, input: {
              pickingListID: $pickingListID
            }) {
              id
            }
          }"""
      }
    }
  ]
}
