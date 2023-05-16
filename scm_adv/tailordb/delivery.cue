package delivery

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"order": {
		type:        "Order"
		description: "Order for this delivery"
		sourceId:    "orderID"
	}
	"orderID": {
		type:        tailordb.#FieldTypeUUID
		description: "order ID for this delivery"
	}
	"product": {
		type:        "Product"
		description: "product "
		sourceId:    "productID"
	}
	"productID": {
		type:        tailordb.#FieldTypeUUID
		description: "CustomerID for this Order"
		required:    true
	}
	"location": {
		type:        "Location"
		description: "Location to deliver"
		sourceId:    "locationID"
	}
	"locationID": {
		type:        tailordb.#FieldTypeUUID
		description: "Location ID id to deliver"
		required:    true
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "delta of quantity. This value will be negative value if the event reduces inventory quantities"
		required:    true
	}
	"deliveryDate": {
		type:        tailordb.#FieldTypeDate
		description: "inventory delivery date"
	}
	"deliveryType": {
		type: tailordb.#FieldTypeEnum
		values: ["INCOMING", "OUTGOING", "TRANSFER"]
		description: "Delivery type"
		required:    true
	}
	"deliveryState": {
		type: tailordb.#FieldTypeEnum
		values: ["UNDISPATCHED", "INTRANSIT", "DELIVERED"]
		description: "Delivery type"
		required:    true
	}

}

Delivery: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Delivery model"
	permission:  permissions.employee
	settings: {
		bulkUpsert:  true
		versioning:  true
		aggregation: true
	}
}
