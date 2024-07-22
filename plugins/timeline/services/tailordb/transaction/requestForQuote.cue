package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

RequestForQuote: tailordb.#Type & {
	Name:        "RequestForQuote"
	Description: "Model for Request for Quote"
	Settings: {
		BulkUpsert:          true
		PublishRecordEvents: true
	}
	Fields: {
		rfqDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of the Request for Quote"
		}
		deadline: {
			Type:        tailordb.#TypeDate
			Description: "Deadline for the Request for Quote"
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Description of the Request for Quote"
		}
		reference: {
			Type:        tailordb.#TypeString
			Description: "Reference of the Request for Quote"
		}
		status: {
			Type:        tailordb.#TypeEnum
			Description: "Status of the Request for Quote"
			AllowedValues: [
				{Value: "draft", Description: "Draft"},
				{Value: "active", Description: "Active"},
				{Value: "closed", Description: "Closed"},
				{Value: "cancelled", Description: "Cancelled"},
			]
		}
		createdAt: tailordb.CreatedAtField
	}
	TypePermission: permissions.adminAccess
}

RequestForQuoteLineItem: tailordb.#Type & {
	Name:        "RequestForQuoteLineItem"
	Description: "Model for Request for quote line item"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		displayOrder: {
			Type:        tailordb.#TypeInt
			Description: "Index of the line item in the request for quote"
			Required:    true
		}
		requestForQuote: {
			Type:        "RequestForQuote"
			Description: "Parent request for quote"
			SourceId:    "requestForQuoteID"
		}
		requestForQuoteID: {
			Type:        tailordb.#TypeUUID
			Description: "Parent request for quote id"
			Required:    true
		}
		product: {
			Type:        "Product"
			Description: "Product. If the product is a buyer product"
			SourceId:    "productID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product id. If the product is a buyer product"
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Line item description"
		}
		quantity: {
			Type:        tailordb.#TypeFloat
			Description: "Quantity of the product"
			Required:    true
		}
	}
	TypePermission: permissions.adminAccess
}
