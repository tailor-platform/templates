package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

Role: tailordb.#Type & {
	Name:        "Role"
	Description: "roles model"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "role name"
			Index:       true
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.adminAccess
}
