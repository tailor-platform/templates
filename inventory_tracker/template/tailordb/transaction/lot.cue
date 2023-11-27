package lot

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

Lot: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Model for Lot. Lot is used for trasability. Lot takes PutAway as a foreign key. With this application, each Lot has one PutAway. This can be customized based on the requirement."
	permission:  permissions.#AllowEveryone
}

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"putAway": {
		type:        "PutAway"
		description: "PutAway model. Lot and PutAway is 1:1."
		sourceId:    "putAwayID"
	}
	"putAwayID": {
		type:        tailordb.#FieldTypeUUID
		description: "putAway ID"
		required:    true
	}
	createdAt: tailordb.#CreatedAtField
}
