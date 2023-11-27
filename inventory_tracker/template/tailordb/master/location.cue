package location

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"code": {
		type:        tailordb.#FieldTypeInteger
		description: "Location code. Location is where the inventories are stored. A location can be a warehouse or a storefront."
	}
	"name": {
		type:        tailordb.#FieldTypeString
		description: "Name of the location."
	}
	"address": {
		type:        tailordb.#FieldTypeString
		description: "Physical address of the location."
	}
	"type": {
		type:        tailordb.#FieldTypeString
		description: "Type of the location. It can be either 'warehouse' or 'storefront'."
	}
	"contactNumber": {
		type:        tailordb.#FieldTypeString
		description: "Contact number of the location."
	}
}

Location: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Location is where the inventories are stored. A location can be a warehouse or a storefront."
	permission:  permissions.#AllowEveryone
}
