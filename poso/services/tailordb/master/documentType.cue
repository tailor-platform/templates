package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

DocumentType: tailordb.#Type & {
	Name:        "DocumentType"
	Description: "Document Type model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the Document Type."
		}
		defaultDocumentStatusID: {
			Type:        tailordb.#TypeUUID
			Description: "Default state of the Document Type."
		}
		defaultDocumentStatus: {
			Type:        "DocumentStatus"
			Description: "DocumentStatus model. DocumentStatus and DocumentType is n:1."
			SourceId:    "defaultDocumentStatusID"
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
