package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Task: tailordb.#Type & {
	Name:        "Task"
	Description: "Task Description"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the task"
			Index:       true
			Required:    true
		}
        description: {
			Type:        tailordb.#TypeString
			Description: "Description of the task"
		}
        status: {
			Type:        tailordb.#TypeString
			Description: "Status of the project"
		}
        dueDate: {
			Type:        tailordb.#TypeDateTime
			Description: "Start date"
			Required:   true
		}
		assigneeId: {
			Type:        tailordb.#TypeUUID
			Description: "ID of the User"
			ForeignKey: true
			ForeignKeyType: "User"
		}
		user: {
			Type:        "User"
			Description: "Link to the User"
			SourceId:    "userId"
		}
		projectId: {
			Type:        tailordb.#TypeUUID
			Description: "ID of the Project"
			ForeignKey: true
			ForeignKeyType: "Project"
		}
		project: {
			Type:        "Project"
			Description: "Link to the Project"
			SourceId:    "projectId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}