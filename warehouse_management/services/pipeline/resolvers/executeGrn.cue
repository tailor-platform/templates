package resolvers

import(
  "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
  "tailor.build/template/services/pipeline:settings"
)

executeGrn: pipeline.#Resolver & {
  Name: "executeGrn"
  Description: "Execute GRN"
  Response: {
    Type: pipeline.Boolean
  }
  PostScript: """
    !isNull(context.pipeline.executeGrn)
  """
  Inputs: [
    {
      Name: "input"
      Required: true
      Type: {
        Name: "ExecuteGrnInput",
        Fields: [
          { Name: "grnID", Type: pipeline.ID, Required: true },
        ]
      }
    },
  ]
  Pipelines: [
    {
      Name: "fetchGrn"
      Description: "Fetch the GoodsReceivedNote record by UUID, provided as the input (grn)"
      PreScript: "context.args.input"
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          query goodsReceivedNote($grnID: ID!){
            goodsReceivedNote(id: $grnID){
              id
              purchaseOrderID
              grnDate
            }
          }"""
      }
      PostScript: """
        args.goodsReceivedNote
      """
    },
    {
      Name: "fetchGrnLineItems"
      Description: "Fetch the GoodsReceivedNoteLineItem records by GoodsReceivedNote ID, provided as the input (grnID)"
      PreScript: "context.args.input"
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          query goodsReceivedNoteLineItems($grnID: ID!){
            goodsReceivedNoteLineItems(query: {goodsReceivedNoteID: {eq: $grnID}}){
              edges {
                node {
                  id
                  productID
                  quantity
                  binID
                  warehouseID
                }
              }
            }
          }"""
      }
      PostScript: """
        args.goodsReceivedNoteLineItems.edges
      """
    },
    {
      Name: "updateStock"
      Description: "Update the stock"
      Invoker: settings.adminInvoker
      ForEach: "context.pipeline.fetchGrnLineItems"
      PreScript: """
      {
        "input": {
          "productID": each.node.productID,
          "quantity": each.node.quantity,
          "binID": each.node.binID,
          "warehouseID": each.node.warehouseID,
          "sourceID": context.args.input.grnID,
          "sourceType": "GRN"
        }
      }
      """
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation updateStock($input: BinStockChangeCreateInput!) {
            createBinStockChange(input: $input) {
    					id
  					}
          }"""
      }
    },
    {
      Name: "updateGrnAndPurchaseOrder"
      Description: "Update the GoodsReceivedNote record by ID, provided as the input (grn)"
      PreScript: """
      {
        "grnID": context.args.input.grnID,
        "purchaseOrderID": context.pipeline.fetchGrn.purchaseOrderID
      }"""
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation finishReceiving($grnID: ID!, $purchaseOrderID: ID!) {
            updateGoodsReceivedNote(id: $grnID, input: {
              status: "complete"
            }) {
              id
            }
            updatePurchaseOrder(id: $purchaseOrderID, input: {
              goodsReceivedNoteID: $grnID
            }) {
              id
            }
          }"""
      }
    }
  ]
}
