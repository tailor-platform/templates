package engagement

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"leadID": {
		type:        tailordb.#FieldTypeUUID
		description: "The engagement lead's ID."
	}
	"accountID": {
		type:        tailordb.#FieldTypeUUID
		description: "The engagement account's ID."
	}
	"engagedDatetime": {
		type:        tailordb.#FieldTypeDatetime
		description: "The time at which the engagement started."
	}
	"nextAction": {
		type:        tailordb.#FieldTypeString
		description: "The engagement's next action."
	}
	"discussion": {
		type:        tailordb.#FieldTypeString
		description: "The engagement's discussion."
	}
	"subject": {
		type:        tailordb.#FieldTypeString
		description: "The engagement's subject."
	}
	"direction": {
		type: tailordb.#FieldTypeEnum
		values: ["INBOUND", "OUTBOUND", "OTHERS"]
		description: "The engagement's direction. Possible values include: INBOUND, OUTBOUND, or OTHERS"
	}
	"engagementType": {
		type:        tailordb.#FieldTypeString
		description: "The engagement type of the engagement."
	}

}

Engagement: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Engagement model"
	permission:  permissions.everyone
}
