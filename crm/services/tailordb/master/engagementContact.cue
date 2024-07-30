package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

EngagementContact: tailordb.#Type & {
	Name:        "EngagementContact"
	Description: "EngagementContact model"
	Indexes: {
		engagementContactCompositeKey: {
			FieldNames: ["contactId", "engagementId"]
			Unique: true
		}
	}
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		contactId: {
			Type:        tailordb.#TypeUUID
			Description: "Contact ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Contact"
		}
		contact: {
			Type:        "Contact"
			Description: "Link to the Contact"
			SourceId:    "contactId"
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
