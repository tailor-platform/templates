package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

EngagementCompany: tailordb.#Type & {
	Name:        "EngagementCompany"
	Description: "EngagementCompany model"
	Indexes: {
		engagementCompanyCompositeKey: {
			FieldNames: ["companyId", "engagementId"]
			Unique: true
		}
	}
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		companyId: {
			Type:        tailordb.#TypeUUID
			Description: "Company ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Company"
		}
		company: {
			Type:        "Company"
			Description: "Link to the Company"
			SourceId:    "companyId"
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
