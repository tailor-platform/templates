package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

DocumentTemplate: tailordb.#Type & {
	Name:        "DocumentTemplate"
	Description: "Document Template model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the Document Template."
		}
		dateLabel: {
			Type:        tailordb.#TypeString
			Description: "Label for Document.date."
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

	TypePermission: permissions.adminAccess
}
