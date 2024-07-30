package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

EngagementDeal: tailordb.#Type & {
	Name:        "EngagementDeal"
	Description: "EngagementDeal model"
	Indexes: {
		engagementDealCompositeKey: {
			FieldNames: ["dealId", "engagementId"]
			Unique: true
		}
	}
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		dealId: {
			Type:        tailordb.#TypeUUID
			Description: "Deal ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Deal"
		}
		deal: {
			Type:        "Deal"
			Description: "Link to the Deal"
			SourceId:    "dealId"
		}
		engagementId: {
			Type:        tailordb.#TypeUUID
			Description: "Engagement ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Engagement"
		}
		engagement: {
			Type:        "Engagement"
			Description: "Link to the Engagement"
			SourceId:    "engagementId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
