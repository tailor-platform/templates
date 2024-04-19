package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

Engagement: tailordb.#Type & {
	Name:        "Engagement"
	Description: "Engagement model"
	Fields: {
		leadID: {
			Type:        tailordb.#TypeUUID
			Description: "The engagement lead's ID."
		}
		accountID: {
			Type:        tailordb.#TypeUUID
			Description: "The engagement account's ID."
		}
		engagedDatetime: {
			Type:        tailordb.#TypeDateTime
			Description: "The time at which the engagement started."
		}
		nextAction: {
			Type:        tailordb.#TypeString
			Description: "The engagement's next action."
		}
		discussion: {
			Type:        tailordb.#TypeString
			Description: "The engagement's discussion."
		}
		subject: {
			Type:        tailordb.#TypeString
			Description: "The engagement's subject."
		}
		direction: {
			Type: tailordb.#TypeEnum
			AllowedValues: [
					{Value: "INBOUND", Description:     "INBOUND type"},
					{Value: "OUTBOUND", Description:    "OUTBOUND type"},
					{Value: "OTHERS", Description:      "OTHERS type"}
				]
			Description: "The engagement's direction. Possible values include: INBOUND, OUTBOUND, or OTHERS"
		}
		engagementType: {
			Type:        tailordb.#TypeString
			Description: "The engagement type of the engagement."
		}
	}

	TypePermission: permissions.employee
}
