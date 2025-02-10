package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

createGrnFromPurchaseOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createGrnFromPurchaseOrder"
	Description: """
		  Creating a GoodsReceivedNote record, while updating the PurchaseOrder record. Used in the receiving screens.

		  Steps:
		  1. Fetch the PurchaseOrder record by UUID, provided as the input (purchaseOrder)
		  2. Fetch the PurchaseOrderLineItems records, with input.purchaseOrderID (fetchPurchaseOrderLineItems)
		  2. Create a GoodsReceivedNote record, with input.purchaseOrderID (createGrn)
		  3. Create GoodsReceivedNoteLineItem records, createGrn.id (createGrnLineItems)
		"""
	Response: {
		Type: {
			Name: "CreateGrnFromPurchaseOrderResult"
			Fields: [
				{ Name: "id", Type: pipeline.ID }
			]
		}
	}
	PostScript: "context.pipeline.createGrn.result"
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createGrnFromPurchaseOrderInput"
				Fields: [
					{Name: "purchaseOrderID", Type: pipeline.ID, Required:   true},
					{Name: "grnDate", Type:         pipeline.Date, Required: true},
					{Name: "status", Type:          pipeline.String},
				]
			}
		},
	]
	Pipelines: [
		// 1. Fetch the PurchaseOrder record by UUID, provided as the input (purchaseOrder)
		{
			Name:        "fetchPurchaseOrder"
			Description: "Fetch the PurchaseOrder record by UUID, provided as the input (purchaseOrder)"

			PreScript: "context.args.input"
			Invoker:   settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query purchaseOrder($purchaseOrderID: ID!){
							purchaseOrder(id: $purchaseOrderID){
									id
									warehouseID
									supplierID
									purchaseOrderDate
							}
					}"""
			}
			PostScript: """
				{
						"result": args.purchaseOrder,
						"isValid": !isNull(args.purchaseOrder)
				}"""
		},
		// 2. Fetch the PurchaseOrderLineItems records, with input.purchaseOrderID (fetchPurchaseOrderLineItems)
		{
			Name:        "fetchPurchaseOrderLineItems"
			Description: "Fetch the PurchaseOrderLineItems records, with input.purchaseOrderID"

			PreScript: "context.args.input"
			Invoker:   settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query purchaseOrderLineItems($purchaseOrderID: ID!){
						purchaseOrderLineItems(query: {purchaseOrderID: {eq: $purchaseOrderID}}) {
							edges {
								node {
									id
									productID
									quantity
								}
							}
						}
					}
					"""
			}
			PostScript: """
				{
						"result": args.purchaseOrderLineItems.edges,
						"isValid": !isNull(args.purchaseOrderLineItems)
				}"""
		},
		// 3. Create a GoodsReceivedNote record, with input.purchaseOrderID (createGrn)
		{
			Name:        "createGrn"
			Description: "Create a GoodsReceivedNote record, with input.purchaseOrderID"
			PreScript: "context.args.input"
			Invoker:   settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation createGrn($purchaseOrderID: ID!, $grnDate: Date!) {
						createGoodsReceivedNote(input: {
							purchaseOrderID: $purchaseOrderID
							grnDate: $grnDate
						}) {
							id
						}
					}"""
			}
			PostScript: """
				{
						"result": args.createGoodsReceivedNote,
						"isValid": !isNull(args.createGoodsReceivedNote)
				}"""
		},
		// 4. Create GoodsReceivedNoteLineItem records, with input.purchaseOrderID (createGrnLineItems)
		{
			Name:        "createGrnLineItems"
			Description: "Create GoodsReceivedNoteLineItem records, with input.purchaseOrderID"

			ForEach: "context.pipeline.fetchPurchaseOrderLineItems.result"
			PreScript: """
				{
				  "input": {
						"goodsReceivedNoteID": context.pipeline.createGrn.result.id,
				    "purchaseOrderLineItemID": each.node.id,
				    "productID": each.node.productID,
				    "quantity": 0
				  }
				}
				"""
			Invoker:   settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation createGrnLineItem(
						$input: GoodsReceivedNoteLineItemCreateInput!
					) {
						createGoodsReceivedNoteLineItem(input: $input) {
							id
						}
					}"""
			}
			PostScript: """
				{
						"result": args.createGoodsReceivedNoteLineItem
				}"""
		},
	]
}
