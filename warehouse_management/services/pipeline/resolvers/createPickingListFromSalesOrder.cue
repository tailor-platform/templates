package resolvers

import (
  "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
  "tailor.build/template/services/pipeline:settings"
)

createPickingListFromSalesOrder: pipeline.#Resolver & {
  Authorization: pipeline.#AuthInsecure
  Name:          "createPickingListFromSalesOrder"
  Description: """
    Create a picking list from a sales order. This will create a picking list and related line items.

    Steps:
    1. Fetch the SalesOrder record by UUID, provided as the input (salesOrder)
    2. Fetch the SalesOrderLineItems records, with input.salesOrderID (fetchSalesOrderLineItems)
    3. Create a PickingList record, with input.salesOrderID (createPickingList)
    4. Create PickingListLineItem records, createPickingList.id (createPickingListLineItems)
  """
  Response: {
    Type: {
      Name: "CreatePickingListFromSalesOrderResult"
      Fields: [
        { Name: "id", Type: pipeline.ID }
      ]
    }
  }
  PostScript: "context.pipeline.createPickingList.result"
  Inputs: [
    {
      Name: "input"
      Required: true
      Type: {
        Name: "createPickingListFromSalesOrderInput"
        Fields: [
          { Name: "salesOrderID", Type: pipeline.ID, Required: true },
          { Name: "pickingListDate", Type: pipeline.Date, Required: true },
          { Name: "status", Type: pipeline.String },
        ]
      }
    }
  ]
  Pipelines: [
    {
      Name: "fetchSalesOrder"
      Description: "Fetch the SalesOrder record by UUID, provided as the input (salesOrder)"
      PreScript: "context.args.input"
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          query salesOrder($salesOrderID: ID!){
            salesOrder(id: $salesOrderID){
              id
              salesOrderDate
            }
          }"""
      }
      PostScript: """
      {
        "result": args.salesOrder,
        "isValid": !isNull(args.salesOrder)
      }
      """
    },
    {
      Name: "fetchSalesOrderLineItems"
      Description: "Fetch the SalesOrderLineItems records, with input.salesOrderID"
      PreScript: "context.args.input"
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          query salesOrderLineItems($salesOrderID: ID!){
            salesOrderLineItems(query: {salesOrderID: {eq: $salesOrderID}}){
              edges {
                node {
                  id
                  productID
                }
              }
            }
          }"""
      }
      PostScript: """
      {
        "result": args.salesOrderLineItems.edges,
        "isValid": !isNull(args.salesOrderLineItems.edges)
      }
      """
    },
    {
      Name: "createPickingList"
      Description: "Create a PickingList record, with input.salesOrderID"
      PreScript: "context.args.input"
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation createPickingList($salesOrderID: ID!, $pickingListDate: Date!){
            createPickingList(input: {salesOrderID: $salesOrderID, pickingListDate: $pickingListDate}){
              id
            }
          }"""
      }
      PostScript: """
      {
        "result": args.createPickingList,
        "isValid": !isNull(args.createPickingList)
      }
      """
    },
    {
      Name: "createPickingListLineItems"
      Description: "Create PickingListLineItem records, createPickingList.id"
      Invoker: settings.adminInvoker
      ForEach: "context.pipeline.fetchSalesOrderLineItems.result"
      PreScript: """
      {
        "input": {
          "pickingListID": context.pipeline.createPickingList.result.id,
          "salesOrderLineItemID": each.node.id,
          "productID": each.node.productID,
          "quantity": 0
        }
      }
      """
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation createPickingListLineItem($input: PickingListLineItemCreateInput!) {
            createPickingListLineItem(input: $input){
              id
            }
          }"""
      }
      PostScript: """
      {
        "result": args.createPickingListLineItem,
        "isValid": !isNull(args.createPickingListLineItem)
      }
      """
    }
  ]
}
