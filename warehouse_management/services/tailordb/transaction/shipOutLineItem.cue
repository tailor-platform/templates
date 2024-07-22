package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

ShipOutLineItem: tailordb.#Type & {
	Name:        "ShipOutLineItem"
	Description: "ShipOutLineItem model"
	Fields: {
		shipOutID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the ship out."
		}

		shipOut: {
			Type:        "ShipOut"
			Description: "ShipOut model. ShipOutLineItem and ShipOut is n:1."
			SourceId:    "shipOutID"
		}

		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the product."
		}

		product: {
			Type:        "Product"
			Description: "Product model. ShipOutLineItem and Product is n:1."
			SourceId:    "productID"
		}

		binID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the bin."
		}

		bin: {
			Type:        "Bin"
			Description: "Bin model. ShipOutLineItem and Bin is n:1."
			SourceId:    "binID"
		}

		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of the product being shipped out."
		}
	}
	TypePermission: permissions.employee
}
