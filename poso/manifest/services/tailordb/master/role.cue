package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

Role: tailordb.#Type & {
	Name:        "Role"
	Description: "ロールマスタ"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "ロール名"
			Index:       true
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.adminAccess
}
