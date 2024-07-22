package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings"
)

reconcileAdvanceShipmentNoticeOutput: {
	Name: "ReconcileAdvanceShipmentNoticeOutput"
	Fields: [
		{Name: "advanceShipmentNoticeID", Type: pipeline.ID},
		{Name: "advanceShipmentNoticeLineItemID", Type: pipeline.ID},
		{Name: "productId", Type: pipeline.ID},
		{Name: "advanceShipmentNoticeQuantity", Type: pipeline.Float},
		{Name: "goodsReceivedQuantity", Type: pipeline.Float},
		{Name: "price", Type: pipeline.Float},
		{Name: "quantityDifference", Type: pipeline.Float},
		{Name: "valueDifference", Type: pipeline.Float},
	]
}

reconcileAdvanceShipmentNotice: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "reconcileAdvanceShipmentNotice"
	Description:   "Check ASN line items and compare it with GRNs to calculate the discrepancies"
	Inputs: [
		{
			Name:     "id"
			Required: true
			Type:     pipeline.ID
		},
	]
	Response: {
		Type:  reconcileAdvanceShipmentNoticeOutput
		Array: true
	}
	PostScript: "context.pipeline.aggregateGrnLineItemsForAdvanceShipmentNoticeLineItem"
	Pipelines: [
		{
			Name:        "fetchAdvanceShipmentNoticeLineItems"
			Description: "Get all line items for an advance shipment notice"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query ($id: ID!) {
					  advanceShipmentNotices (query: { advanceShipmentNoticeID: { eq: $id }}) {
					    collection {
					      id
					      productID
					      quantity
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
				  "advanceShipmentNoticeLineItemID": each.id
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query ($advanceShipmentNoticeLineItemID: ID!) {
					  aggregateGoodsReceivedNoteLineItems(query: { advanceShipmentNoticeLineItemID: {eq: $advanceShipmentNoticeLineItemID} }) {
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
