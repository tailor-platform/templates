package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Warehouse: tailordb.#Type & {
	Name:        "Warehouse"
	Description: "Warehouse model"
	Fields: {
		code: {
			Type:        tailordb.#TypeInt
			Description: "Unique warehouse code."
		}

		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the warehouse."
		}

		address: {
			Type:        tailordb.#TypeString
			Description: "Address of the warehouse."
		}

		type: {
			Type:        tailordb.#TypeString
			Description: "Type of the warehouse."
		}

		contactNumber: {
			Type:        tailordb.#TypeString
			Description: "Contact number of the warehouse."
		}
	}
	TypePermission: permissions.employee
}
