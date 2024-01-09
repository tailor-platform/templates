package lead

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	leadSource: {
		type:        tailordb.#FieldTypeString
		description: "The lead's source."
	}
	companyName: {
		type:        tailordb.#FieldTypeString
		description: "The lead's company name."
	}
	convertedDate: {
		type:        tailordb.#FieldTypeDate
		description: "When the lead was converted."
	}
	convertedAccountID: {
		type:        tailordb.#FieldTypeUUID
		description: "The account id of the converted lead."
	}
	engagementID: {
		type:        tailordb.#FieldTypeUUID
		description: "The lead's engagement."
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
	dealAmount: {
		type:        tailordb.#FieldTypeString
		description: "The lead's deal amount."
	}
	stage: {
		type:        tailordb.#FieldTypeEnum
		description: "The lead's sales stage."
		values: ["Open", "WIP", "Lost", "Won"]
		defaultValue: {
			stringValue: "Open"
		}
	}
}

Lead: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Lead model"
	permission:  permissions.everyone
}
