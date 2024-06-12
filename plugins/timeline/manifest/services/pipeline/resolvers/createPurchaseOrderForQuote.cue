package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/manifest/settings"
)

createPurchaseOrderForQuoteInput: {
	Name: "CreatePurchaseOrderForQuoteInput"
	Fields: [
		{Name: "supplierID", Type:        pipeline.ID},
		{Name: "quoteID", Type:           pipeline.ID},
		{Name: "purchaseOrderDate", Type: pipeline.Date},
		{Name: "expiryDate", Type:        pipeline.Date},
		{Name: "reference", Type:         pipeline.String},
		{Name: "status", Type:            pipeline.String},
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
			Operation:   pipeline.#GraphqlOperation & {
				Query: """
					  query fetchQuoteLineItems($quoteID: ID!) {
					    quoteLineItems(query: {quoteID: { eq: $quoteID}}) {
					      collection {
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
					"""
			}
			PostScript: "args.quoteLineItems.collection"
		},
		{
			Name:        "createPurchaseOrder"
			Description: "Create a new purchase order"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation:   pipeline.#GraphqlOperation & {
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
				    "displayOrder": each.displayOrder,
				    "purchaseOrderID": context.pipeline.createPurchaseOrder.id,
				    "quoteLineItemID": each.id,
				    "productID": each.productID,
				    "price": each.price,
				    "quantity": each.quantity,
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
