package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

BinStock: tailordb.#Type & {
	Name:        "BinStock"
	Description: "BinStock model"
	Fields: {
		binID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the bin."
		}

		bin: {
			Type:        "Bin"
			Description: "Bin model. BinStock and Bin is n:1."
			SourceId:    "binID"
		}

		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the product."
		}

		product: {
			Type:        "Product"
			Description: "Product model. BinStock and Product is n:1."
			SourceId:    "productID"
		}

		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of the product in the bin."
		}
	}

	TypePermission: permissions.employee
}
