package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

ManufacturingOrderTransition: tailordb.#Type & {
	Name:        "ManufacturingOrderTransition"
	Description: "Status tracking of manufacturing order"
	Settings: {
		BulkUpsert:  true
	}
	Fields: {
		moId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated MO"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "ManufacturingOrder"
		}
		mo: {
			Type:        "ManufacturingOrder"
			Description: "Link to the MO"
			SourceId:    "moId"
		}
		fromStatus: {
			Type:        tailordb.#TypeEnum
			Description: "from status description"
			AllowedValues: [
				{Value: "Draft", Description: "Draft"},
                {Value: "Planned", Description: "Planned"},
				{Value: "In_Progress", Description: "In Progress"},
				{Value: "Completed", Description: "Completed"},
				{Value: "Canceled", Description: "Canceled"},
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 'Draft'
				"""
			}
		}
		toStatus: {
			Type:        tailordb.#TypeEnum
			Description: "to status description"
			AllowedValues: [
				{Value: "Draft", Description: "Draft"},
                {Value: "Planned", Description: "Planned"},
				{Value: "In_Progress", Description: "In Progress"},
				{Value: "Completed", Description: "Completed"},
				{Value: "Canceled", Description: "Canceled"},
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 'Draft'
				"""
			}
		}
		timeInStatus: {
			Type:        tailordb.#TypeInt
			Description: "Minutes in particular status"
			Required:   true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
