package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings"
)

createPurchaseOrderForQuoteInput: {
	Name: "CreatePurchaseOrderForQuoteInput"
	Fields: [
		{Name: "supplierID", Type: pipeline.ID},
		{Name: "quoteID", Type: pipeline.ID},
		{Name: "purchaseOrderDate", Type: pipeline.Date},
		{Name: "reference", Type: pipeline.String},
		{Name: "status", Type: pipeline.String},
	]
}

createPurchaseOrderForQuote: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createPurchaseOrderForQuote"
	Description:   "Generating a purchase order from a Quote and connect line items"
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type:     createPurchaseOrderForQuoteInput
		},
	]
	Response: {
		Type: pipeline.ID
	}
	PostScript: "context.pipeline.createPurchaseOrder.id"
	Pipelines: [
		{
			Name:        "fetchQuoteLineItems"
			Description: "Get line items from Quote"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					  query fetchQuoteLineItems($quoteID: ID!) {
					    quoteLineItems(query: {quoteID: { eq: $quoteID}}) {
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
			PostScript: "args.quoteLineItems.edges"
		},
		{
			Name:        "createPurchaseOrder"
			Description: "Create a new purchase order"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
										        mutation ($input: PurchaseOrderCreateInput!) {
										          createPurchaseOrder(input: $input) {
										            id
														    supplierID
														    quoteID
														    purchaseOrderDate
														    reference
														    status
														  }
														}"""
			}
			PostScript: "args.createPurchaseOrder"
		},
		{
			Name:        "createPurchaseOrderLineItems"
			Description: "Create line items for the purchase order"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.fetchQuoteLineItems"
			PreScript: """
				{
				  "input": {
				    "displayOrder": each.node.displayOrder,
				    "purchaseOrderID": context.pipeline.createPurchaseOrder.id,
				    "quoteLineItemID": each.node.id,
				    "productID": each.node.productID,
				    "price": each.node.price,
				    "quantity": each.node.quantity,
				  }
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
										  mutation ($input: PurchaseOrderLineItemCreateInput!) {
										    createPurchaseOrderLineItem(input: $input) {
										      id
										    }
										  }"""
			}
			PostScript: "args.createPurchaseOrderLineItem.id"
		},
	]
}
