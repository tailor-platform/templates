package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Tax: tailordb.#Type & {
	Name:        "Tax"
	Description: "Tax model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the tax."
		}
		taxRate: {
			Type:        tailordb.#TypeFloat
			Description: "Tax rate. 20% is 0.2"
		}
		inactive: {
			Type:        tailordb.#TypeBool
			Description: "Field used to delete the record. Instead of deleting the record, we set this field to true. This is to keep the data integrity."
			Hooks: {
				CreateExpr: "false"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
