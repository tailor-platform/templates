package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings"
)

createAdvanceShipmentNoticeForInvoiceInput: {
	Name: "CreateAdvanceShipmentNoticeForInvoiceInput"
	Fields: [
		{
			Name: "supplierID"
			Type: pipeline.ID
		},
		{
			Name: "invoiceID"
			Type: pipeline.ID
		},
		{
			Name: "asnDate"
			Type: pipeline.Date
		},
		{
			Name: "reference"
			Type: pipeline.String
		},
		{
			Name: "status"
			Type: pipeline.String
		},
	]
}

createAdvanceShipmentNoticeForInvoice: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createAdvanceShipmentNoticeForInvoice"
	Description:   "Generating an invoice from a invoice and connect line items"
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type:     createAdvanceShipmentNoticeForInvoiceInput
		},
	]
	Response: {
		Type: pipeline.ID
	}
	PostScript: "context.pipeline.createAdvanceShipmentNotice.id"
	Pipelines: [
		{
			Name:        "fetchInvoiceLineItems"
			Description: "Get line items from invoice"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					  query fetchInvoiceLineItems($invoiceID: ID!) {
					    invoiceLineItems(query: {invoiceID: { eq: $invoiceID}}) {
					      edges {
									node {
										id
										displayOrder
										product {
											id
											name
											description
											price
										}
										productID
										price
										quantity
									}
					      }
					    }
					  }
					"""
			}
			PostScript: "args.invoiceLineItems.edges"
		},
		{
			Name:        "createAdvanceShipmentNotice"
			Description: "Create a new advance shipment notice"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					  mutation ($input: AdvanceShipmentNoticeCreateInput!) {
					    createAdvanceShipmentNotice(input: $input) {
					      id
					      supplierID
					      invoiceID
					      asnDate
					      reference
					      status
					    }
					  }
					"""
			}
			PostScript: "args.createAdvanceShipmentNotice"
		},
		{
			Name:        "createAdvanceShipmentNoticeLineItems"
			Description: "Create line items for the ASN"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.fetchInvoiceLineItems"
			PreScript: """
				{
				  "input": {
				    "displayOrder": each.node.displayOrder,
				    "advanceShipmentNoticeID": context.pipeline.createAdvanceShipmentNotice.id,
				    "invoiceLineItemID": each.node.id,
				    "productID": each.node.productID,
				    "quantity": each.node.quantity,
				  }
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					  mutation ($input: AdvanceShipmentNoticeLineItemCreateInput!) {
					    createAdvanceShipmentNoticeLineItem(input: $input) {
					      id
					    }
					  }
					"""
			}
			PostScript: "args.createAdvanceShipmentNoticeLineItem.id"
		},
	]
}
