package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

WorkingHour: tailordb.#Type & {
	Name:        "WorkingHour"
	Description: "Used to define the hours during which a work center will be available"
	Settings: {
		BulkUpsert:  true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Working hour name"
			Required:  true
		}
		standardHoursPerWeek: {
			Type:        tailordb.#TypeInt
			Description: "Standard hours per week"
			Required:  true
		}
		timeZone: {
			Type:        tailordb.#TypeString
			Description: "Time zone"
			Required:  true
		}
		isActive: {
			Type:        tailordb.#TypeBool
			Description: "Is active?"
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
