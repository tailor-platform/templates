package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

PutAway: tailordb.#Type & {
	Name:        "PutAway"
	Description: "Model for Put Away. Putting away means receiving and storing goods to a location. This model takes PurchaseOrder as a foreign key. Each PurchaseOrder can have multiple PutAway."
	Settings: {
		Aggregation: true
	}
	Fields: {
		purchaseOrder: {
			Type:        "PurchaseOrder"
			Description: "PurchaseOrder. Each PutAway requires one PurchaseOrder. Each PurchaseOrder can have multiple PutAway in case the order is received as multiple shipping."
			SourceId:    "purchaseOrderID"
		}
		purchaseOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "purchaseOrder ID"
			Required:    true
		}
		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Put away quantity"
			Required:    true
		}
		putAwayDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of put away"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
