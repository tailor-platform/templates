package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Operation: tailordb.#Type & {
	Name:        "Operation"
	Description: "A Specific operation that needs to be performed at a bom"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Operation Name"
			Required:   true
		}
		bomId: {
			Type:        tailordb.#TypeUUID
			Description: "associated bomId"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "Bom"
		}
		bom: {
			Type:        "Bom"
			Description: "Link to the BOM"
			SourceId:    "bomId"
		}
		workCenterId: {
			Type:        tailordb.#TypeUUID
			Description: "ID of the WorkCenter at which the operation is to be performed"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "WorkCenter"
		}
		workCenter: {
			Type:        "WorkCenter"
			Description: "Link to the WorkCenter at which the operation is to be performed"
			SourceId:    "workCenterId"
		}
		duration: {
			Type:        tailordb.#TypeInt
			Description: "Duration in minutes for the operation"
			Required:   true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "The task that needs to be done as part of the operation"
		}
		documentUrl: {
			Type:        tailordb.#TypeString
			Description: "The link to the document that is to be referred."
		}
		order: {
			Type:        tailordb.#TypeInt
			Description: "sequence order description"
		}
		isActive: {
			Type:        tailordb.#TypeBool
			Description: "Is the operation active?"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : true
				"""
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
