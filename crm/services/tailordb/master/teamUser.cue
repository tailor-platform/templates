package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

TeamUser: tailordb.#Type & {
	Name:        "TeamUser"
	Description: "TeamUser model"
	Indexes: {
		teamUserCompositeKey: {
			FieldNames: ["teamId", "userId"]
			Unique: true
		}
	}
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		teamId: {
			Type:        tailordb.#TypeUUID
			Description: "Team ID"
			Required:    true
			Index:       true
			ForeignKey:  true
			ForeignKeyType: "Team"
		}
		team: {
			Type:        "Team"
			Description: "Link to the Team"
			SourceId:    "teamId"
		}
		userId: {
			Type:        tailordb.#TypeUUID
			Description: "User ID"
			Required:    true
			Index:       true
			ForeignKey:  true
			ForeignKeyType: "User"
		}
		user: {
			Type:        "User"
			Description: "Link to the User"
			SourceId:    "userId"
		}
		isSecondaryUser: {
			Type:        tailordb.#TypeBool
			Description: "Is Secondary User?"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
