package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings"
)

createInvoiceForPurchaseOrderInput: {
	Name: "CreateInvoiceForPurchaseOrderInput"
	Fields: [
		{
			Name: "supplierID"
			Type: pipeline.ID
		},
		{
			Name: "purchaseOrderID"
			Type: pipeline.ID
		},
		{
			Name: "invoiceDate"
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
		{
			Name: "dueDate"
			Type: pipeline.Date
		},
	]
}

createInvoiceForPurchaseOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createInvoiceForPurchaseOrder"
	Description:   "Generating an invoice from a purchase order and connect line items"
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type:     createInvoiceForPurchaseOrderInput
		},
	]
	Response: {
		Type: pipeline.ID
	}
	PostScript: "context.pipeline.createInvoice.id"
	Pipelines: [
		{
			Name:        "fetchPurchaseOrderLineItems"
			Description: "Get line items from purchase order"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					  query fetchPurchaseOrderLineItems($purchaseOrderID: ID!) {
					    purchaseOrderLineItems(query: {purchaseOrderID: { eq: $purchaseOrderID}}) {
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
			PostScript: "args.purchaseOrderLineItems.edges"
		},
		{
			Name:        "createInvoice"
			Description: "Create a new invoice"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					  mutation ($input: InvoiceCreateInput!) {
					    createInvoice(input: $input) {
					      id
					      supplierID
					      purchaseOrderID
					      invoiceDate
					      dueDate
					      reference
					      status
					    }
					  }
					"""
			}
			PostScript: "args.createInvoice"
		},
		{
			Name:        "createInvoiceLineItems"
			Description: "Create line items for the invoice"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.fetchPurchaseOrderLineItems"
			PreScript: """
				{
				  "input": {
				    "displayOrder": each.node.displayOrder,
				    "invoiceID": context.pipeline.createInvoice.id,
				    "purchaseOrderLineItemID": each.node.id,
				    "productID": each.node.productID,
				    "price": each.node.price,
				    "quantity": each.node.quantity,
				  }
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					  mutation ($input: InvoiceLineItemCreateInput!) {
					    createInvoiceLineItem(input: $input) {
					      id
					    }
					  }
					"""
			}
			PostScript: "args.createInvoiceLineItem.id"
		},
	]
}
