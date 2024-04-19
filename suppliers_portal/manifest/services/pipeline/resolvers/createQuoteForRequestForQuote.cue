package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/manifest/settings"
)

createQuoteForRfqInput: {
  Name: "CreateQuoteForRfqInput"
  Fields: [
    { Name: "supplierID", Type: pipeline.ID },
    { Name: "requestForQuoteID", Type: pipeline.ID },
    { Name: "quoteDate", Type: pipeline.Date },
    { Name: "expiryDate", Type: pipeline.Date },
    { Name: "reference", Type: pipeline.String },
    { Name: "status", Type: pipeline.String },
  ]
}

createQuoteForRequestForQuote: pipeline.#Resolver & {
  Authorization: pipeline.#AuthInsecure
  Name: "createQuoteForRequestForQuote"
  Description: "Generating a quote from a RFQ and connect line items"
  Inputs: [
    {
      Name: "input"
      Required: true
      Type: createQuoteForRfqInput
    }
  ]
  Response: {
    Type: pipeline.ID
  }
  PostScript: "context.pipeline.createQuote.id"
  Pipelines: [
    {
      Name: "fetchRequestForQuoteLineItems"
      Description: "Get line items from RFQ"
      Invoker: settings.adminInvoker
      PreScript: "context.args.input"
      Operation: pipeline.#GraphqlOperation & {
        Query: """
        query fetchRequestForQuoteLineItems($requestForQuoteID: ID!) {
          requestForQuoteLineItems(query: {requestForQuoteID: { eq: $requestForQuoteID}}) {
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
              quantity
            }
          }
        }
        """
      }
      PostScript: "args.requestForQuoteLineItems.collection"
    },
    {
      Name: "createQuote"
      Description: "Create a new quote"
      Invoker: settings.adminInvoker
      PreScript: "context.args"
      Operation: pipeline.#GraphqlOperation & {
        Query: """
        mutation createQuote($input: QuoteCreateInput!) {
          createQuote(input: $input) {
            id
            supplierID
            requestForQuoteID
            quoteDate
            expiryDate
            reference
            status
          }
        }
        """
      }
      PostScript: "args.createQuote"
    },
    {
      Name: "createQuoteLineItems"
      Description: "Create line items for the quote"
      Invoker: settings.adminInvoker
      ForEach: "context.pipeline.fetchRequestForQuoteLineItems"
      PreScript: """
      {
        "input": {
          "displayOrder": each.displayOrder,
          "quoteID": context.pipeline.createQuote.id,
          "requestForQuoteLineItemID": each.id,
          "productID": each.productID,
          "price": 0,
          "quantity": each.quantity
        }
      }
      """
      Operation: pipeline.#GraphqlOperation & {
        Query: """
        mutation ($input: QuoteLineItemCreateInput!) {
          createQuoteLineItem(input: $input) {
            id
          }
        }
        """
      }
      PostScript: "args.createQuoteLineItem.id"
    }
  ]
}
