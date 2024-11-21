package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Project: tailordb.#Type & {
	Name:        "Project"
	Description: "Project Description"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the project"
			Index:       true
			Required:    true
		}
        description: {
			Type:        tailordb.#TypeString
			Description: "Description of the project"
		}
        status: {
			Type:        tailordb.#TypeString
			Description: "Status of the project"
		}
        startDate: {
			Type:        tailordb.#TypeDateTime
			Description: "Start date"
		}
		endDate: {
			Type:        tailordb.#TypeDateTime
			Description: "End date"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}