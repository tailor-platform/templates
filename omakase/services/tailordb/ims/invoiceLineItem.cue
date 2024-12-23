package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

InvoiceLineItem: commonType.#CommonType & {
	Name:        "InvoiceLineItem"
	Description: "InvoiceLineItem model"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		invoiceID: {
			Type:        tailordb.#TypeUUID
			Description: "Invoice ID"
			Required:    true
		}
		invoice: {
			Type:        "Invoice"
			Description: "Invoice model. Invoice and this model is n:1."
			SourceId:    "invoiceID"
		}
		unitPrice: {
			Type:        tailordb.#TypeFloat
			Description: "unit cost"
			Required:    true
		}
		variantID: {
			Type:        tailordb.#TypeUUID
			Description: "Variant ID"
		}
		variant: {
			Type:        "ProductVariant"
			Description: "Variant"
			SourceId:    "variantID"
		}
		quantity: {
			Type:        tailordb.#TypeFloat
			Description: "quantity"
			Required:    true
		}
		taxable: {
			Type:        tailordb.#TypeBool
			Description: "taxable"
		}
	}
	TypePermission: permissions.editorAccess
}
