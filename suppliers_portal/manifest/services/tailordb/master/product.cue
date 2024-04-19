package master

import (
  "github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb/permissions"
)

Product: tailordb.#Type & {
	Name:        "Product"
	Description: "Buyer's product catalog"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		code: {
			Type:        tailordb.#TypeString
			Description: "product code."
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the product."
			Required:    true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Description of the product."
		}
		price: {
			Type:        tailordb.#TypeFloat
			Description: "Price of the product."
			Required:    true
		}
		uom: {
			Type:        tailordb.#TypeString
			Description: "Unit of measure of the product."
			Required:    true
		}
	}
	TypePermission: permissions.adminAccess
}
