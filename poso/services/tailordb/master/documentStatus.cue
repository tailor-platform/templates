package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

DocumentStatus: tailordb.#Type & {
	Name:        "DocumentStatus"
	Description: "Document Status model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the Document Status."
		}

		documentTypeID: {
			Type:        tailordb.#TypeUUID
			Description: "documentType ID"
		}

		documentType: {
			Type:        "DocumentType"
			Description: "Document Type model. Document and DocumentTemplate is n:1."
			SourceId:    "documentTypeID"
		}

		isEditable: {
			Type:        tailordb.#TypeBool
			Description: "Field used to check if the state should allow documents to be editable."
			Required:    true
		}

		triggersStockEvent: {
			Type:        tailordb.#TypeBool
			Description: "Field used to check if the state should trigger stock event."
			Required:    true
		}

		toStates: {
			Type:        tailordb.#TypeNested
			Description: "Array of state IDs that this state can be transitioned to."
			Array:       true
			Fields: {[string]: tailordb.#Field} & {
				documentStatusID: {
					Type:        tailordb.#TypeUUID
					Description: "State ID"
				}
				documentStatus: {
					Type:        "DocumentStatus"
					Description: "DocumentStatus model. DocumentStatus and DocumentStatus is n:1."
					SourceId:    "documentStatusID"
				}
			}
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
