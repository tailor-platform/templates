package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Team: tailordb.#Type & {
	Name:        "Team"
	Description: "Team model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Team Name"
			Required:    true
			Unique:      true
			Index:       true
		}
		isDeleted: {
			Type:        tailordb.#TypeBool
			Description: "Is Deleted?"
			Hooks: {
				CreateExpr: "false"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
