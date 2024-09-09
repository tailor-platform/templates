package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Bom: tailordb.#Type & {
	Name:        "Bom"
	Description: "Bom description"
	Settings: {
		BulkUpsert:  true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the BOM "
			Required:   true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Name of the BOM"
		}
		outputQuantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of the final product produced"
			Required:   true
		}
		isActive: {
			Type:        tailordb.#TypeBool
			Description: "Is the bom active?"
			Hooks: {
				CreateExpr:  "true"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
