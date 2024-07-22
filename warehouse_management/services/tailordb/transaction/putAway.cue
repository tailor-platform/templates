package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

PutAway: tailordb.#Type & {
	Name:        "PutAway"
	Description: "PutAway model"
	Fields: {
		purchaseOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the purchase order."
		}

		purchaseOrder: {
			Type:        "PurchaseOrder"
			Description: "PurchaseOrder model. PurchaseOrderLineItem and PurchaseOrder is n:1."
			SourceId:    "purchaseOrderID"
		}

		putAwayDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of the put-away process."
		}
	}
	TypePermission: permissions.employee
}
