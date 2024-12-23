package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

PurchaseOrder: commonType.#CommonType & {
	Name:        "PurchaseOrder"
	Description: "PurchaseOrder model"
	Fields: {
		documentNumber: {
			Type:        tailordb.#TypeString
			Description: "documentNumber"
			Required:    true
		}
		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "supplier ID"
			Required:    true
		}
		supplier: {
			Type:        "Contact"
			Description: "Contact model. Contact and this model is n:1."
			SourceId:    "supplierID"
		}
		date: {
			Type:        tailordb.#TypeDateTime
			Description: "date"
		}
		billToID: {
			Type:        tailordb.#TypeUUID
			Description: "billTo ID"
		}
		billTo: {
			Type:        "Contact"
			Description: "Contact model. Contact and this model is n:1."
			SourceId:    "billToID"
		}
		shipToID: {
			Type:        tailordb.#TypeUUID
			Description: "shipTo ID"
		}
		shipTo: {
			Type:        "Contact"
			Description: "Contact model. Contact and this model is n:1."
			SourceId:    "shipToID"
		}
		shipVia: {
			Type:        tailordb.#TypeString
			Description: "shipVia"
		}
		trackingNumber: {
			Type:        tailordb.#TypeString
			Description: "trackingNumber"
		}
		shippingContactPhone: {
			Type:        tailordb.#TypeString
			Description: "shippingContactPhone"
		}
		shippingContactName: {
			Type:        tailordb.#TypeString
			Description: "shippingContactName"
		}
		exFactoryDate: {
			Type:        tailordb.#TypeDateTime
			Description: "exFactoryDate"
		}
		dueDate: {
			Type:        tailordb.#TypeDateTime
			Description: "dueDate"
		}
		terms: {
			Type:        tailordb.#TypeString
			Description: "terms"
		}
		shippingInstructions: {
			Type:        tailordb.#TypeString
			Description: "shippingInstructions"
		}
		notes: {
			Type:        tailordb.#TypeString
			Description: "notes"
		}
		approvedBy: {
			Type:        tailordb.#TypeString
			Description: "approvedBy"
		}
		pulledBy: {
			Type:        tailordb.#TypeString
			Description: "pulledBy"
		}
		receivedBy: {
			Type:        tailordb.#TypeString
			Description: "receivedBy"
		}
	}
	TypePermission: permissions.adminAccess
}
