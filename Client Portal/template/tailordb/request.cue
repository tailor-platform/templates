package request

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/common:permissions"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	system: {
		type:        tailordb.#FieldTypeEnum
		description: "Type of the hardware"
		values:			 ["PC", "MAC", "PRINTER", "SERVER", "OTHER"]
		required:    true
	}

	kind: {
		type:        tailordb.#FieldTypeEnum
		description: "The kind of service needed"
		values:      ["TROUBLESHOOTING_AND_REPAIR", "NETWORKING", "SOFTWARE_INSTALLATION", "HARDWARE_SETUP", "PURCHASING", "OTHER"]
		required:    true
	}

	description: {
		type:        tailordb.#FieldTypeString
		description: "Description of the request"
	}

	status: {
		type:        tailordb.#FieldTypeString
		description: "Current status of the case. OPEN or COMPLETED"
		// values:			 ["OPEN", "COMPLETED"]
		defaultValue: {
			stringValue: "OPEN"
		}
	}

	completedAt: {
		type:        tailordb.#FieldTypeDatetime
		description: "Timestamp of the completion of the case"
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

Request: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Request model"
	permission: permissions.loggedinUser
}
