package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

ContactList: tailordb.#Type & {
	Name:        "ContactList"
	Description: "ContactList model"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		isDeleted: {
			Type:        tailordb.#TypeBool
			Description: "Is Deleted?"
			Hooks: {
				CreateExpr: "false"
			}
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "Contact List Name"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
