package resolvers

import (
  "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
  "tailor.build/template/services/pipeline:settings"
)

deletePurchaseOrderById: pipeline.#Resolver & {
  Authorization: pipeline.#AuthInsecure
  Name:          "deletePurchaseOrderById"
  Description: """
    Delete a PurchaseOrderLineItem record by ID. And clean up related line items.
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
      Name:        "fetchPurchaseOrderLineItems"
      Description: "Fetch the PurchaseOrderLineItem records by PurchaseOrder ID, provided as the input (purchaseOrderID)"
      PreScript:   "context.args"
      Invoker:     settings.adminInvoker
      Operation:   pipeline.#GraphqlOperation & {
        Query: """
          query purchaseOrderLineItems($id: ID!){
            purchaseOrderLineItems(query: {purchaseOrderID: {eq: $id}}){
              edges {
                node {
                  id
                }
              }
            }
          }"""
      }
      PostScript: """
          args.purchaseOrderLineItems.edges
        """
    },
    {
      Name:        "deleteLineItems"
      Description: "Delete the PurchaseOrderLineItem records"
      Invoker:     settings.adminInvoker
      ForEach:     "context.pipeline.fetchPurchaseOrderLineItems"
      PreScript: """
            {
              "id": each.node.id
            }"""
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation deletePurchaseOrderLineItem($id: ID!){
            deletePurchaseOrderLineItem(id: $id)
          }"""
      }
    },
    {
      Name:        "deletePurchaseOrder"
      Description: "Delete the PurchaseOrder record"
      Invoker:     settings.adminInvoker
      PreScript: """
        {
          "id": context.args.id
        }"""
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation deletePurchaseOrder($id: ID!){
            deletePurchaseOrder(id: $id)
          }"""
      }
    },
  ]
}
