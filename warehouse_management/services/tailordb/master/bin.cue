package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Bin: tailordb.#Type & {
	Name:        "Bin"
	Description: "Bin model"
	Fields: {
		warehouseID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the warehouse."
		}

		barcode: {
			Type:        tailordb.#TypeInt
			Description: "Barcode of the bin."
		}

		shelf: {
			Type:        tailordb.#TypeString
			Description: "Shelf location of the bin."
		}

		isDefault: {
			Type:        tailordb.#TypeBool
			Description: "Indicates if this bin is the default bin."
		}
	}
	TypePermission: permissions.employee
}
