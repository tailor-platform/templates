package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings"
)

reconcilePurchaseOrderOutput: {
	Name: "ReconcilePurchaseOrderOutput"
	Fields: [
		{Name: "purchaseOrderID", Type: pipeline.ID},
		{Name: "purchaseOrderLineItemID", Type: pipeline.ID},
		{Name: "productID", Type: pipeline.ID},
		{Name: "purchaseOrderQuantity", Type: pipeline.Float},
		{Name: "invoiceQuantity", Type: pipeline.Float},
		{Name: "price", Type: pipeline.Float},
		{Name: "quantityDifference", Type: pipeline.Float},
		{Name: "valueDifference", Type: pipeline.Float},
	]
}

reconcilePurchaseOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "reconcilePurchaseOrder"
	Description:   "Check purchase order line items against invoices to calculate the discrepancies."
	Inputs: [
		{
			Name:     "id"
			Required: true
			Type:     pipeline.ID
		},
	]
	Response: {
		Type:  reconcilePurchaseOrderOutput
		Array: true
	}
	PostScript: "context.pipeline.aggregateInvoiceItemsForPOItem"
	Pipelines: [
		{
			Name:        "fetchPurchaseOrderLineItems"
			Description: "Get all line items for purchase order"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query ($id: ID!) {
					purchaseOrderLineItems (query: { purchaseOrderID: { eq: $id }}) {
						edges {
							node {
								id
								productID
								quantity
								price
							}
						}
					}
				}"""
			}
			PostScript: "args.purchaseOrderLineItems.edges"
		},
		{
			Name:        "aggregateInvoiceItemsForPOItem"
			Description: "Get Invoice line items associated with the purchase order line item and calculate the total quantities"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.fetchPurchaseOrderLineItems"
			PreScript: """
				{
					"purchaseOrderLineItemID": each.node.id
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query ($purchaseOrderLineItemID: ID!) {
						aggregateInvoiceLineItems(query: { purchaseOrderLineItemID: {eq: $purchaseOrderLineItemID} }) {
							sum {
								quantity
							}
						}
					}"""
			}
			PostScript: """
				{
				  "purchaseOrderID": context.args.id,
				  "purchaseOrderLineItemID": each.node.id,
				  "productID": each.node.productID,
				  "purchaseOrderQuantity": each.node.quantity,
				  "invoiceQuantity": args.aggregateInvoiceLineItems[0].sum.quantity,
				  "price": each.price,
				  "quantityDifference": args.aggregateInvoiceLineItems[0].sum.quantity - each.node.quantity,
				  "valueDifference": (args.aggregateInvoiceLineItems[0].sum.quantity - each.node.quantity) * each.node.price
				}
				"""
		},
	]
}
