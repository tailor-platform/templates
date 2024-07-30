package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Company: tailordb.#Type & {
	Name:        "Company"
	Description: "Company Model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Company Name"
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
		url: {
			Type:        tailordb.#TypeString
			Description: "Company URL"
		}
		linkedInUrl: {
			Type:        tailordb.#TypeString
			Description: "Company's LinkedIn URL"
		}
		logoUrl: {
			Type:        tailordb.#TypeString
			Description: "Company Logo URL"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
