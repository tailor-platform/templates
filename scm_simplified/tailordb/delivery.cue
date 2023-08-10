package delivery

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"order": {
		type:        "Order"
		description: "Order associated with this delivery"
		sourceId:    "orderID"
	}
	"orderID": {
		type:        tailordb.#FieldTypeUUID
		description: "ID of the order associated with this delivery"
	}
	"product": {
		type:        "Product"
		description: "Product to be delivered"
		sourceId:    "productID"
	}
	"productID": {
		type:        tailordb.#FieldTypeUUID
		description: "ID of the product to be delivered"
	}
	"location": {
		type:        "Location"
		description: "Location to deliver to"
		sourceId:    "locationID"
	}
	"locationID": {
		type:        tailordb.#FieldTypeUUID
		description: "ID of the location to deliver to"
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Delta of the quantity. This value will be negative if the delivery reduces inventory quantities"
	}
	"deliveryDate": {
		type:        tailordb.#FieldTypeDate
		description: "Date set for the delivery"
	}
	"deliveryType": {
		type: tailordb.#FieldTypeEnum
		values: ["INCOMING", "OUTGOING"]
		description: "Type of delivery"
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
