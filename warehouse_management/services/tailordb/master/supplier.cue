package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Supplier: tailordb.#Type & {
	Name:        "Supplier"
	Description: "Supplier model"
	Fields: {
		code: {
			Type:        tailordb.#TypeInt
			Description: "Unique supplier code."
		}

		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the supplier."
		}

		contactNumber: {
			Type:        tailordb.#TypeString
			Description: "Contact number of the supplier."
		}

		email: {
			Type:        tailordb.#TypeString
			Description: "Email of the supplier."
		}

		address: {
			Type:        tailordb.#TypeString
			Description: "Address of the supplier."
		}
	}
	TypePermission: permissions.employee
}
