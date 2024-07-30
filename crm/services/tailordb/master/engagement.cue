package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Engagement: tailordb.#Type & {
	Name:        "Engagement"
	Description: "Engagement model"
	Fields: {
		active: {
			Type:        tailordb.#TypeBool
			Description: "Is active?"
		}
		activityType: {
			Type:        tailordb.#TypeString
			Description: "Activity type"
			Required:    true
		}
		userId: {
			Type:        tailordb.#TypeUUID
			Description: "Owner ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "User"
		}
		type: {
			Type:        tailordb.#TypeString
			Description: "Engagement type"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
