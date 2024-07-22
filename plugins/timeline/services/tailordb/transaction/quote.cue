package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

Quote: tailordb.#Type & {
	Name:        "Quote"
	Description: "Quote model"
	Settings: {
		BulkUpsert:          true
		PublishRecordEvents: true
	}
	Fields: {
		supplier: {
			Type:        "Supplier"
			Description: "Supplier of the quote"
			SourceId:    "supplierID"
		}
		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "Supplier ID"
			Required:    true
		}
		requestForQuote: {
			Type:        "RequestForQuote"
			Description: "Request for quote"
			SourceId:    "requestForQuoteID"
		}
		requestForQuoteID: {
			Type:        tailordb.#TypeUUID
			Description: "Request for quote ID"
		}
		quoteDate: {
			Type:        tailordb.#TypeDate
			Description: "Quote date"
			Required:    true
		}
		expiryDate: {
			Type:        tailordb.#TypeDate
			Description: "Expiry date"
			Required:    true
		}
		reference: {
			Type:        tailordb.#TypeString
			Description: "Human readable reference"
			Required:    true
		}
		status: {
			Type:        tailordb.#TypeEnum
			Description: "Quote status"
			AllowedValues: [
				{Value: "draft", Description: "Draft"},
				{Value: "submitted", Description: "Submitted"},
				{Value: "accepted", Description: "Accepted"},
				{Value: "rejected", Description: "Rejected"},
				{Value: "expired", Description: "Expired"},
			]
			Required: true
		}
		createdAt: tailordb.CreatedAtField
	}
	TypePermission: permissions.adminAccess
}

QuoteLineItem: tailordb.#Type & {
	Name:        "QuoteLineItem"
	Description: "Quote line item model"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		displayOrder: {
			Type:        tailordb.#TypeInt
			Description: "Item index"
			Required:    true
		}
		quote: {
			Type:        "Quote"
			Description: "Quote"
			SourceId:    "quoteID"
		}
		quoteID: {
			Type:        tailordb.#TypeUUID
			Description: "Quote ID"
			Required:    true
		}
		requestForQuoteLineItem: {
			Type:        "RequestForQuoteLineItem"
			Description: "Request for quote line item"
			SourceId:    "requestForQuoteLineItemID"
		}
		requestForQuoteLineItemID: {
			Type:        tailordb.#TypeUUID
			Description: "Request for quote line item ID"
			Required:    true
		}
		product: {
			Type:        "Product"
			Description: "Product"
			SourceId:    "productID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Description"
		}
		price: {
			Type:        tailordb.#TypeFloat
			Description: "Price"
			Required:    true
		}
		quantity: {
			Type:        tailordb.#TypeFloat
			Description: "Quantity"
			Required:    true
		}
		total: {
			Type:        tailordb.#TypeFloat
			Description: "Total"
			Hooks: {
				CreateExpr: "_value.price * _value.quantity"
				UpdateExpr: CreateExpr
			}
		}
	}
	TypePermission: permissions.adminAccess
}
