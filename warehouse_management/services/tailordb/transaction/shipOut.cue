package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

ShipOut: tailordb.#Type & {
	Name:        "ShipOut"
	Description: "ShipOut model"
	Fields: {
		salesOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the sales order."
		}

		salesOrder: {
			Type:        "SalesOrder"
			Description: "SalesOrder model. ShipOut and SalesOrder is n:1."
			SourceId:    "salesOrderID"
		}

		shipOutDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of the ship out."
		}
	}
	TypePermission: permissions.employee
}
