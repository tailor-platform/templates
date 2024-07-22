package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Store: tailordb.#Type & {
	Name:        "Store"
	Description: "Store model"
	Fields: {
		code: {
			Type:        tailordb.#TypeInt
			Description: "Unique store code."
		}

		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the store."
		}

		address: {
			Type:        tailordb.#TypeString
			Description: "Address of the store."
		}

		type: {
			Type:        tailordb.#TypeString
			Description: "Type of the store."
		}

		contactNumber: {
			Type:        tailordb.#TypeString
			Description: "Contact number of the store."
		}
	}
	TypePermission: permissions.employee
}
