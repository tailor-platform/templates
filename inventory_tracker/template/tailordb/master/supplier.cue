package supplier

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"code": {
		type:        tailordb.#FieldTypeInteger
		description: "Supplier code."
	}
	"name": {
		type:        tailordb.#FieldTypeString
		description: "Name of the supplier."
	}
	"contactNumber": {
		type:        tailordb.#FieldTypeString
		description: "Contact number of the supplier."
	}
	"email": {
		type:        tailordb.#FieldTypeString
		description: "Email address of the supplier."
	}
	"address": {
		type:        tailordb.#FieldTypeString
		description: "Physical address of the supplier."
	}
}

Supplier: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Supplier Model"
	permission:  permissions.#AllowEveryone
}
