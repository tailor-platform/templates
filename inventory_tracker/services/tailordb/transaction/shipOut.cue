package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

ShipOut: tailordb.#Type & {
	Name:        "ShipOut"
	Description: "Model for Ship Out. Shipping out means the goods leaving the location to a customer to fulfill the sales order. This model takes SalesOrder as a foreign key. Each SalesOrder can have multiple ShipOut."
	Settings: {
		Aggregation: true
	}
	Fields: {
		salesOrder: {
			Type:        "SalesOrder"
			Description: "SalesOrder. Each ShipOut requires one SalesOrder. Each SalesOrder can have multiple ShipOut in case the order is delivered in multiple shippings."
			SourceId:    "salesOrderID"
		}
		salesOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "salesOrder ID"
			Required:    true
		}
		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Ship out quantity"
			Required:    true
		}
		shipOutDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of ship out"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
