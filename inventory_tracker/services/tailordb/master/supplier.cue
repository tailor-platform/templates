package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Supplier: tailordb.#Type & {
	Name:        "Supplier"
	Description: "Supplier Model"
	Fields: {
		code: {
			Type:        tailordb.#TypeInt
			Description: "Supplier code."
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the supplier."
		}
		address: {
			Type:        tailordb.#TypeString
			Description: "Physical address of the supplier."
		}
		email: {
			Type:        tailordb.#TypeString
			Description: "Email address of the supplier."
		}
		contactNumber: {
			Type:        tailordb.#TypeString
			Description: "Contact number of the supplier."
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
