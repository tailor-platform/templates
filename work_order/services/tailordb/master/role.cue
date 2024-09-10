package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Role: tailordb.#Type & {
	Name:        "Role"
	Description: "User Roles"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the Role"
			Index:       true
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.adminAccess
}
