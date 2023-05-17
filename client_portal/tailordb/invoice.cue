package invoice

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/common:permissions"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	amount: {
		type:        tailordb.#FieldTypeInteger
		description: "Amount owned"
		defaultValue: {
			intValue: 0
		}
	}

	status: {
		type:        tailordb.#FieldTypeString
		description: "Current status of the invoice. DUE or PAID."
		// values:			 ["DUE", "PAID"]
		defaultValue: {
			stringValue: "DUE"
		}
	}

	request: {
		type:        "Request"
		description: "The request associated to the invoice"
		sourceId:    "requestId"
	}

	requestId: {
		type:        tailordb.#FieldTypeUUID
		description: "UUID of the referenced request"
		required:    true
	}

	client: {
		type:        "Client"
		description: "The client who submitted the case"
		sourceId:    "clientId"
	}

	clientId: {
		type:        tailordb.#FieldTypeUUID
		description: "UUID of the referenced client"
		required:    true
	}
}

Invoice: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Invoice model"
	permission:  permissions.loggedinUser
}
