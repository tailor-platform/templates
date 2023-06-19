package invoice

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"invoiceName": {
		type:        tailordb.#FieldTypeString
		description: "invoice name."
		required:    true
	}
	"invoiceCode": {
		type:        tailordb.#FieldTypeInteger
		description: "invoice code."
	}
	"quote": {
		type:        tailordb.#FieldTypeInteger
		description: "Price per unit."
		required:    true
	}
	"state": {
		type:        "State"
		description: "state for this invoice"
		sourceId:    "stateID"
	}
	"stateID": {
		type:        tailordb.#FieldTypeUUID
		description: "state ID for invoice"
	}

}

Invoice: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Invoice model"
	permission:  permissions.strict
}
