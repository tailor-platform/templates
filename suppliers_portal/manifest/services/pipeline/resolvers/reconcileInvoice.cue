package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/manifest/settings"
)

reconcileInvoiceOutput: {
	Name: "ReconcileInvoiceOutput"
	Fields: [
		{Name: "invoiceID", Type:             pipeline.ID},
		{Name: "invoiceLineItemID", Type:     pipeline.ID},
		{Name: "productID", Type:             pipeline.ID},
		{Name: "goodsReceivedQuantity", Type: pipeline.Float},
		{Name: "invoiceQuantity", Type:       pipeline.Float},
		{Name: "price", Type:                 pipeline.Float},
		{Name: "quantityDifference", Type:    pipeline.Float},
		{Name: "valueDifference", Type:       pipeline.Float},
	]
}

reconcileInvoice: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "reconcileInvoice"
	Description:   "Check invoice line items and compare it with GRNs to calculate the discrepancies"
	Inputs: [
		{
			Name:     "id"
			Required: true
			Type:     pipeline.ID
		},
	]
	Response: {
		Type:  reconcileInvoiceOutput
		Array: true
	}
	PostScript: "context.pipeline.aggregateGrnLineItemsForInvoiceLineItem"
	Pipelines: [
		{
			Name:        "fetchInvoiceLineItems"
			Description: "Get all line items for an invoice"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation:   pipeline.#GraphqlOperation & {
				Query: """
					  query ($id: ID!) {
					    invoiceLineItems (query: { invoiceID: { eq: $id }}) {
					      collection {
					        id
					        productID
					        quantity
					        price
					      }
					    }
					  }
					"""
			}
			PostScript: "args.invoiceLineItems.collection"
		},
		{
			Name:        "aggregateGrnLineItemsForInvoiceLineItem"
			Description: "Get Goods received notice line items associated with the invoice line items"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.fetchInvoiceLineItems"
			PreScript: """
				{
				  "invoiceLineItemID": each.id
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query ($invoiceLineItemID: ID!) {
					  aggregateGoodsReceivedNoteLineItems(query: { invoiceLineItemID: {eq: $invoiceLineItemID} }) {
					    sum {
					      quantity
					    }
					  }
					}
					"""
			}
			PostScript: """
				{
				  "invoiceID": context.args.id,
				  "invoiceLineItemID": each.id,
				  "productID": each.productID,
				  "goodsReceivedQuantity": args.aggregateGoodsReceivedNoteLineItems[0].sum.quantity,
				  "invoiceQuantity": each.quantity,
				  "price": each.price,
				  "quantityDifference": args.aggregateGoodsReceivedNoteLineItems[0].sum.quantity - each.quantity,
				  "valueDifference": (args.aggregateGoodsReceivedNoteLineItems[0].sum.quantity - each.quantity) * each.price
				}
				"""
		},
	]
}
