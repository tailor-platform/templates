package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

Shipment: commonType.#CommonType & {
	Name:        "Shipment"
	Description: "Shipment model"
	Fields: {
		shipmentNumber: {
			Type:        tailordb.#TypeString
			Description: "Shipment number"
		}
		customerID: {
			Type:           tailordb.#TypeUUID
			Description:    "Contact ID"
			ForeignKey:     true
			ForeignKeyType: "Contact"
		}
		customer: {
			Type:        "Contact"
			Description: "Contact model. Contact and this model is n:1"
			SourceId:    "customerID"
		}
		salesOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "salesOrder ID"
		}
		salesOrder: {
			Type:        "SalesOrder"
			Description: "SalesOrder model. SalesOrder and this model is n:1."
			SourceId:    "salesOrderID"
		}
		date: {
			Type:        tailordb.#TypeDateTime
			Description: "date"
		}
	}
	TypePermission: permissions.adminAccess
}
