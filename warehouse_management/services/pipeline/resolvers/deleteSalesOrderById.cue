package resolvers

import (
  "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
  "tailor.build/template/services/pipeline:settings"
)

deleteSalesOrderById: pipeline.#Resolver & {
  Authorization: pipeline.#AuthInsecure
  Name:          "deleteSalesOrderById"
  Description: """
    Delete a SalesOrderLineItem record by ID. And clean up related line items.
  """
  Response: {
    Type: pipeline.Boolean
  }
  PostScript: """
    !isNull(context.pipeline.deleteLineItems)
  """
  Inputs: [
    {Name: "id"
      Required: true
      Type:     pipeline.ID
    },
  ]
  Pipelines: [
    {
      Name:        "fetchSalesOrderLineItems"
      Description: "Fetch the SalesOrderLineItem records by SalesOrder ID, provided as the input (salesOrderID)"
      PreScript:   "context.args"
      Invoker:     settings.adminInvoker
      Operation:   pipeline.#GraphqlOperation & {
        Query: """
          query salesOrderLineItems($id: ID!){
            salesOrderLineItems(query: {salesOrderID: {eq: $id}}){
              edges {
                node {
                  id
                }
              }
            }
          }"""
      }
      PostScript: """
        args.salesOrderLineItems.edges"""
    },
    {
      Name:        "deleteLineItems"
      Description: "Delete the SalesOrderLineItem records"
      Invoker:     settings.adminInvoker
      ForEach:     "context.pipeline.fetchSalesOrderLineItems"
      PreScript: """
        {
          "id": each.node.id
        }"""
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation deleteSalesOrderLineItem($id: ID!){
            deleteSalesOrderLineItem(id: $id)
          }"""
      }
    },
    {
      Name:        "deleteSalesOrder"
      Description: "Delete the SalesOrder record"
      Invoker:     settings.adminInvoker
      PreScript:   "context.args"
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation deleteSalesOrder($id: ID!){
            deleteSalesOrder(id: $id)
          }"""
      }
    },
  ]
}
