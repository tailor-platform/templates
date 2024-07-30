package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

DealStage: tailordb.#Type & {
	Name:        "DealStage"
	Description: "DealStage model"
	Fields: {
		dealPipelineId: {
			Type:        tailordb.#TypeUUID
			Description: "DealPipeline ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "DealPipeline"
		}
		dealPipeline: {
			Type:        "DealPipeline"
			Description: "Link to the DealPipeline"
			SourceId:    "dealPipelineId"
		}
		displayOrder: {
			Type:        tailordb.#TypeInt
			Description: "Display Order"
			Required:    true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Description"
		}
		label: {
			Type:        tailordb.#TypeString
			Description: "Label"
			Required:    true
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "Name"
			Required:    true
		}
		type: {
			Type:        tailordb.#TypeString
			Description: "Stage type"
		}
		probability: {
			Type:        tailordb.#TypeFloat
			Description: "Default probability"
			Required:    true
		}
		closedWon: {
			Type:        tailordb.#TypeBool
			Description: "Closed Won?"
			Required:    true
		}
		closedLost: {
			Type:        tailordb.#TypeBool
			Description: "Closed Lost?"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
