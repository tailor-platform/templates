package bom

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

UOM: tailordb.#Type & {
	Name:        "Uom"
	Description: "Unit of Measure"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the unit of measure"
			Required:    true
			Index:       true
			Unique:      true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Detailed description of the unit of measure"
		}
		isActive: {
			Type:        tailordb.#TypeBool
			Description: "Indicates if the unit of measure is active"
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
