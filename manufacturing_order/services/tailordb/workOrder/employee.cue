package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Employee: tailordb.#Type & {
	Name:        "Employee"
	Description: "Basic Employee details"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the Employee"
		}
		role: {
			Type:        tailordb.#TypeString
			Description: "Role of the Employee"
		}
		isActive: {
			Type:        tailordb.#TypeBool
			Description: "Is the employee active?"
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
