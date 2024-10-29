package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

RequestForQuoteSupplier: tailordb.#Type & {
	Name:        "RequestForQuoteSupplier"
	Description: "Suppliers invites to quote for a specific RFQ"
	Settings: {
		BulkUpsert:          true
		PublishRecordEvents: true
	}
	Fields: {
		requestForQuote: {
			Type:        "RequestForQuote"
			Description: "The request for quote."
			SourceId:    "requestForQuoteID"
		}
		requestForQuoteID: {
			Type:        tailordb.#TypeUUID
			Description: "The ID of the request for quote."
			Required:    true
		}
		supplier: {
			Type:        "Supplier"
			Description: "The supplier."
			SourceId:    "supplierID"
		}
		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "The ID of the supplier."
			Required:    true
		}
		quote: {
			Type:        "Quote"
			Description: "The submitted quote by the supplier."
			SourceId:    "quoteID"
		}
		quoteID: {
			Type:        tailordb.#TypeUUID
			Description: "The ID of the quote."
		}
		createdAt: tailordb.CreatedAtField
	}
	TypePermission: permissions.adminAccess
}
