package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

User: tailordb.#Type & {
	Name:        "User"
	Description: "User of the system"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the user"
			Index:       true
			Required:    true
		}
		email: {
			Type:        tailordb.#TypeString
			Description: "Email of the user"
			Index:       true
			Unique:      true
			Required:    true
		}
		roles: {
			Type:        tailordb.#TypeUUID
			Description: "Role IDs of the user"
			Array:       true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.adminAccess
}
