package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

PurchaseOrder: tailordb.#Type & {
	Name:        "PurchaseOrder"
	Description: "PurchaseOrder model"
	Fields: {
		warehouseID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the warehouse."
		}

		warehouse: {
			Type:        "Warehouse"
			Description: "Warehouse model. PurchaseOrder and Warehouse is n:1."
			SourceId:    "warehouseID"
		}

		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the supplier."
		}

		supplier: {
			Type:        "Supplier"
			Description: "Supplier model. PurchaseOrder and Supplier is n:1."
			SourceId:    "supplierID"
		}

		purchaseOrderDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of the purchase order."
		}
	}
	TypePermission: permissions.employee
}
