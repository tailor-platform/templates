package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

User: tailordb.#Type & {
	Name:        "User"
	Description: "管理者ユーザーマスタ"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "管理者ユーザー名"
			Index:       true
			Required:    true
		}
		email: {
			Type:        tailordb.#TypeString
			Description: "管理者メールアドレス"
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
