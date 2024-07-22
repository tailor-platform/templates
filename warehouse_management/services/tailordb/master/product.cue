package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Product: tailordb.#Type & {
	Name:        "Product"
	Description: "Product model"
	Fields: {
		code: {
			Type:        tailordb.#TypeString
			Description: "Unique product code."
		}

		brand: {
			Type:        tailordb.#TypeString
			Description: "Brand of the product."
		}

		style: {
			Type:        tailordb.#TypeString
			Description: "Style of the product."
		}

		category: {
			Type:        tailordb.#TypeString
			Description: "Category of the product."
		}

		cost: {
			Type:        tailordb.#TypeFloat
			Description: "Cost of the product."
		}

		msrp: {
			Type:        tailordb.#TypeFloat
			Description: "Manufacturer's suggested retail price of the product."
		}

		uom: {
			Type:        tailordb.#TypeString
			Description: "Unit of measure of the product."
		}

		sellingStartDate: {
			Type:        tailordb.#TypeDate
			Description: "Start date of selling the product."
		}
	}
	TypePermission: permissions.employee
}
