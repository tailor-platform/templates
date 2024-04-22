package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

Product: tailordb.#Type & {
	Name:        "Product"
	Description: "Product model"
	Fields: {
		code: {
			Type:        tailordb.#TypeInt
			Description: "Product code."
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the product."
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Description of the product."
		}
		price: {
			Type:        tailordb.#TypeFloat
			Description: "Price of the product."
		}
		uom: {
			Type:        tailordb.#TypeString
			Description: "Unit of measure of the product."
		}
		sellingStartDate: {
			Type:        tailordb.#TypeDate
			Description: "The date this product starts selling. This field is used to calculate the sales velocity used for demand forecasting."
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}

