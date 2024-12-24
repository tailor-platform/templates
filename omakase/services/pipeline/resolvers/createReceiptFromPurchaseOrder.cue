package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline:settings"
)

createReceiptFromPurchaseOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createReceiptFromPurchaseOrder"
	Description: """
		This pipeline creates a new receipt from a purchase order. 
		
		The steps are:
		1. Fetch the purchase order and its line items
		2. Create a receipt and get the ID
		3. bulk create the receipt line items
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createReceiptFromPurchaseOrderInput"
				Fields: [
					{Name: "purchaseOrderID", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {Type: pipeline.String}
	PostScript: "context.pipeline.createReceipt.id"
	Pipelines: [
		{
			Name:        "fetchPurchaseOrder"
			Description: "Fetch the Purchase Order and its line items"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
query ($purchaseOrderID: ID!) {
  purchaseOrder(id: $purchaseOrderID) {
    id
    supplierID
    documentNumber
  }
  purchaseOrderLineItems(query: {purchaseOrderID: {eq: $purchaseOrderID}}) {
    edges {
      node {
        id
        variantID
        quantity
        unitCost
      }
    }
  }
}"""
			}
			PostScript: """
				            {
				                "purchaseOrder": args.purchaseOrder,
				                "purchaseOrderLineItems": args.purchaseOrderLineItems.edges
				            }"""
			PostValidation: """
				isNull(context.pipeline.fetchPurchaseOrder.purchaseOrder) ? 
				"Purchase Order not found" : 
				""
				"""
		},
		{
			Name:        "createReceipt"
			Description: "Create a new Receipt from the Purchase Order"
			Invoker:     settings.adminInvoker
			PreScript: """
				{
				    "input": {
				        "purchaseOrderID": context.pipeline.fetchPurchaseOrder.purchaseOrder.id,
				        "supplierID": context.pipeline.fetchPurchaseOrder.purchaseOrder.supplierID,
				        "receiptNumber": "Receipt - " + string(context.pipeline.fetchPurchaseOrder.purchaseOrder.documentNumber),
				    }
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					mutation ($input: ReceiptCreateInput!) {
					    createReceipt(input: $input) {
					        id
					    }
					}
					"""
			}
			PostScript: "args.createReceipt"
		},
		{
			Name:        "createReceiptLineItems"
			Description: "Create Receipt line items from the purchase order line items"
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.fetchPurchaseOrder.purchaseOrderLineItems) > 0"
			PreScript: """
				{
				    "input": context.pipeline.fetchPurchaseOrder.purchaseOrderLineItems.map(item, {
				        "receiptID": context.pipeline.createReceipt.id,
				        "variantID": item.node.variantID,
				        "quantity": item.node.quantity,
				        "subtotalUnitCost": item.node.unitCost,
				    })
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					mutation ($input: [ReceiptLineItemCreateInput]) {
					    bulkUpsertReceiptLineItems(input: $input)
					}
					"""
			}
			PostScript: "args.bulkUpsertReceiptLineItems"
		},
	]
}
