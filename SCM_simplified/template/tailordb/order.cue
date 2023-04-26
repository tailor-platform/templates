package order

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"placedDate": {
		type:        tailordb.#FieldTypeDate
		description: "date for this order"
	}
	"product": {
		type:        "Product"
		description: "product "
		sourceId:    "productID"
	}
	"productID": {
		type:        tailordb.#FieldTypeUUID
		description: "CustomerID for this Order"
	}
	"orderType": {
		type: tailordb.#FieldTypeEnum
		values: ["PURCHASE", "SALES"]
		description: "Order type"
		required:    true
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "delta of quantity. This value will be negative value if the event reduces inventory quantities"
	}

}

Order: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Order model"
	permission:  permissions.employee
}
