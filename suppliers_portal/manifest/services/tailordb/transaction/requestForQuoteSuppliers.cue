package transaction

import (
  "github.com/tailor-platform/tailorctl/schema/v2/tailordb"
  "tailor.build/template/manifest/services/tailordb/permissions"
)


RequestForQuoteSuppliers: tailordb.#Type & {
  Name: "RequestForQuoteSuppliers"
  Description: "Suppliers invites to quote for a specific RFQ"
  Settings: {
		BulkUpsert: true
	}
  Fields: {
    requestForQuote: {
      Type:         "RequestForQuote"
      Description:  "The request for quote."
      SourceId:     "requestForQuoteID"
    }
    requestForQuoteID: {
      Type:        tailordb.#TypeUUID
      Description: "The ID of the request for quote."
      Required:    true
    }
    supplier: {
      Type: "Supplier"
      Description: "The supplier."
      SourceId:    "supplierID"
    }
    supplierID: {
      Type:        tailordb.#TypeUUID
      Description: "The ID of the supplier."
      Required:    true
    }
    quote: {
      Type: "Quote"
      Description: "The submitted quote by the supplier."
      SourceId:    "quoteID"
    }
    quoteID: {
      Type:        tailordb.#TypeUUID
      Description: "The ID of the quote."
    }
    CreatedAt: tailordb.CreatedAtField
  }
  TypePermission: permissions.adminAccess
}
