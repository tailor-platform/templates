package customerAccount

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	lead: {
		type:        "Lead"
		description: "The account's lead"
		sourceId:    "leadID"
	}
	leadID: {
		type:        tailordb.#FieldTypeUUID
		description: "The account lead ID."
	}
	companyName: {
		type:        tailordb.#FieldTypeString
		description: "The account's name."
	}
	contact: {
		type:        tailordb.#FieldTypeNested
		description: "The lead's contact."
		fields: {
			contactName: {
				type:        tailordb.#FieldTypeString
				description: "The lead's contact name."
			}
			emailAddress: {
				type:        tailordb.#FieldTypeString
				description: "The lead's contact email address."
			}
			phoneNumber: {
				type:        tailordb.#FieldTypeString
				description: "The lead's contact phone number."
			}
		}
	}
}

CustomerAccount: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "CustomerAccount model"
	permission:  permissions.employee
}
