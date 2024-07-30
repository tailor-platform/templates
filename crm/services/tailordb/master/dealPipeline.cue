package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

DealPipeline: tailordb.#Type & {
	Name:        "DealPipeline"
	Description: "DealPipeline description"
	Fields: {
		displayOrder: {
			Type:        tailordb.#TypeInt
			Description: "Display Order"
			Required:    true
		}
		label: {
			Type:        tailordb.#TypeString
			Description: "Label"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
