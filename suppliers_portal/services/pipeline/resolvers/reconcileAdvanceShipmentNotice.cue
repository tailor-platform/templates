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
		{Name: "productID", Type: pipeline.ID},
		{Name: "goodsReceivedQuantity", Type: pipeline.Float},
		{Name: "advanceShipmentNoticeQuantity", Type: pipeline.Float},
		{Name: "quantityDifference", Type: pipeline.Float}
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
					  advanceShipmentNoticeLineItems (query: { advanceShipmentNoticeID: { eq: $id }}) {
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
			PostScript: "args.advanceShipmentNoticeLineItems.edges"
		},
		{
			Name:        "aggregateGrnLineItemsForAdvanceShipmentNoticeLineItem"
			Description: "Get Goods received notice line items associated with the asn items"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.fetchAdvanceShipmentNoticeLineItems"
			PreScript: """
				{
				  "advanceShipmentNoticeLineItemID": each.node.id
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query ($advanceShipmentNoticeLineItemID: ID!) {
					  aggregateGoodsReceivedNoteLineItems(query: { advanceShipmentNoteLineItemID: {eq: $advanceShipmentNoticeLineItemID} }) {
					    sum {
					      quantity
					    }
					  }
					}
					"""
			}
			PostScript: """
				{
				  "advanceShipmentNoticeID": context.args.id,
				  "advanceShipmentNoticeLineItemID": each.node.id,
				  "productID": each.node.productID,
				  "goodsReceivedQuantity": args.aggregateGoodsReceivedNoteLineItems[0].sum.quantity,
				  "advanceShipmentNoticeQuantity": each.node.quantity,
				  "quantityDifference": args.aggregateGoodsReceivedNoteLineItems[0].sum.quantity - each.node.quantity
				}
				"""
		},
	]
}
