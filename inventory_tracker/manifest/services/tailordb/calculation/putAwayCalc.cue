package calculation

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

PutAwayCalc: tailordb.#Type & {
	Name:        "PutAwayCalc"
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
		putAwayID: {
			Type:        tailordb.#TypeUUID
			Description: "PutAway ID"
			Required:    true
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
			Required:    true
		}
		locationID: {
			Type:        tailordb.#TypeUUID
			Description: "Location ID"
			Required:    true
		}
		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "Supplier ID"
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
		purchaseOrderDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of order"
			Required:    true
		}
		leadTime: {
			Type:        tailordb.#TypeInt
			Description: "Date of lead time"
			Hooks:   {
				CreateExpr: "(date(_value.putAwayDate) - date(_value.purchaseOrderDate)).getHours()/24"
				UpdateExpr: "(date(_value.putAwayDate) - date(_value.purchaseOrderDate)).getHours()/24"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}