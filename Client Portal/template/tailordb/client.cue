package client

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/common:permissions"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	billingAddress: {
		type:        tailordb.#FieldTypeString
		description: "Address for billing purposes"
	}

	email: {
		type:        tailordb.#FieldTypeString
		description: "Email address"
	}

	user: {
		type:        "User"
		description: "The user account associated with this client"
		sourceId:    "userId"
	}

	userId: {
		type:        tailordb.#FieldTypeUUID
		description: "UUID of the referenced user"
	}
}

Client: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Client model"
	permission: permissions.loggedinUser
}
