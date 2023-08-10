package order

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"placedDate": {
		type:        tailordb.#FieldTypeDate
		description: "Date the order was placed"
	}
	"product": {
		type:        "Product"
		description: "product"
		sourceId:    "productID"
	}
	"productID": {
		type:        tailordb.#FieldTypeUUID
		description: "productID for this Order"
	}
	"orderType": {
		type: tailordb.#FieldTypeEnum
		values: ["PURCHASE", "SALES"]
		description: "Type of order"
		required:    true
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Delta of quantity. This value will be negative if the order reduces inventory quantities"
	}
}

Order: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Order model"
	permission:  permissions.employee
}
