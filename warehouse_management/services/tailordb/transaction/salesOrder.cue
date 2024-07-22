package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

SalesOrder: tailordb.#Type & {
	Name:        "SalesOrder"
	Description: "SalesOrder model"
	Fields: {
		storeID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the store."
		}

		store: {
			Type:        "Store"
			Description: "Store model. salesOrder and Store is n:1."
			SourceId:    "storeID"
		}

		salesOrderDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of the sales order."
		}
	}
	TypePermission: permissions.employee
}
