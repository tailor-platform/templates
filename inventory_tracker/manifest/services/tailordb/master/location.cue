package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

Location: tailordb.#Type & {
	Name:        "Location"
	Description: "Location is where the inventories are stored. A location can be a warehouse or a storefront."
	Fields: {
		code: {
			Type:        tailordb.#TypeInt
			Description: "Location code. Location is where the inventories are stored. A location can be a warehouse or a storefront."
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the location."
		}
		address: {
			Type:        tailordb.#TypeString
			Description: "Physical address of the location."
		}
		type: {
			Type:        tailordb.#TypeString
			Description: "Type of the location. It can be either 'warehouse' or 'storefront'."
		}
		contactNumber: {
			Type:        tailordb.#TypeString
			Description: "Contact number of the location."
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}