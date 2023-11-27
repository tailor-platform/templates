package putAway

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

PutAway: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Model for Put Away. Putting away means receiving and storing goods to a location. This model takes PurchaseOrder as a foreign key. Each PurchaseOrder can have multiple PutAway."
	permission:  permissions.#AllowEveryone
	settings: {
		aggregation: true
	}
}

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"purchaseOrder": {
		type:        "PurchaseOrder"
		description: "PurchaseOrder. Each PutAway requires one PurchaseOrder. Each PurchaseOrder can have multiple PutAway in case the order is received as multiple shipping."
		sourceId:    "purchaseOrderID"
	}
	"purchaseOrderID": {
		type:        tailordb.#FieldTypeUUID
		description: "purchaseOrder ID"
		required:    true
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Put away quantity"
		required:    true
	}
	"putAwayDate": {
		type:        tailordb.#FieldTypeDate
		description: "Date of put away"
		required:    true
	}
	createdAt: tailordb.#CreatedAtField
}
