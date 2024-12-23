package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

Invoice: commonType.#CommonType & {
	Name:        "Invoice"
	Description: "Invoice model"
	Fields: {
		invoiceNumber: {
			Type:        tailordb.#TypeString
			Description: "Invoice number"
		}
		customerID: {
			Type:           tailordb.#TypeUUID
			Description:    "Contact model. Contact and this model is n:1"
			ForeignKey:     true
			ForeignKeyType: "Contact"
		}
		customer: {
			Type:        "Contact"
			Description: "Customer contact"
			SourceId:    "customerID"
		}
		shipmentID: {
			Type:        tailordb.#TypeUUID
			Description: "Shipment ID (Origin of the invoice)"
		}
		shipment: {
			Type:        "Shipment"
			Description: "Shipment model. (Origin of the invoice) Shipment and this model is n:1."
			SourceId:    "shipmentID"
		}
		date: {
			Type:        tailordb.#TypeDateTime
			Description: "date"
		}
		quickbookInvoiceId: {
			Type:        tailordb.#TypeString
			Description: "Quickbook invoice ID"
		}
		invoiceStatus: {
			Type:        tailordb.#TypeEnum
			Description: "inventoryType"
			AllowedValues: [
				{Value: "DRAFT", Description: "DRAFT State, meaning it can be updated"},
				{Value: "PUSHEDTOQB", Description: "CANNOT BE EDITED. Pushed To QB State, meaning it has been pushed to QuickBooks"},
				{Value: "CLOSED", Description: "CANNOT BE EDITED. CLOSED State, meaning it has been closed"},
			]
			Hooks: {
				CreateExpr: "_value == null ? 'DRAFT' : _value"
			}
		}
		pushedToQBAt: {
			Type:        tailordb.#TypeDateTime
			Description: "Date when the invoice was pushed to QuickBooks"
			Hooks: {
				UpdateExpr: "_value.invoiceStatus == 'PUSHEDTOQB' ? now() : null"
			}
		}
	}
	TypePermission: permissions.editorAccess
}
