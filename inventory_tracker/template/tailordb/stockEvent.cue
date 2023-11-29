package stockEvent

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

StockEvent: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "StockEvent model"
	permission:  permissions.#AllowEveryone
	settings: {
		aggregation: true
	}
}

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"lot": {
		type:        "Lot"
		description: "Lot is the minimum unit to manage inventory here. Any stock movements has to specify a Lot for the tracability purpose"
		sourceId:    "lotID"
	}
	"lotID": {
		type:        tailordb.#FieldTypeUUID
		description: "Lot ID"
		required:    true
	}
	"eventDate": {
		type:        tailordb.#FieldTypeDate
		description: "Date of the event"
		required:    true
	}
	"incrementalQuantity": {
		type:        tailordb.#FieldTypeInteger
		description: "delta of quantity. This value will be negative value if the event reduces inventory quantities"
		required:    true
	}
	"reason": {
		type:        tailordb.#FieldTypeString
		description: "The reason for the stock event, such as putaway, shipout, return, adjuestment, etc."
		required:    true
	}
	createdAt: tailordb.#CreatedAtField
}
