package shipOut

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

ShipOut: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Model for Ship Out. Shipping out means the goods leaving the location to a customer to fulfill the sales order. This model takes SalesOrder as a foreign key. Each SalesOrder can have multiple ShipOut."
	permission:  permissions.#AllowEveryone
	settings: {
		aggregation: true
	}
}

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"salesOrder": {
		type:        "SalesOrder"
		description: "SalesOrder. Each ShipOut requires one SalesOrder. Each SalesOrder can have multiple ShipOut in case the order is delivered in multiple shippings."
		sourceId:    "salesOrderID"
	}
	"salesOrderID": {
		type:        tailordb.#FieldTypeUUID
		description: "salesOrder ID"
		required:    true
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Ship out quantity"
		required:    true
	}
	"shipOutDate": {
		type:        tailordb.#FieldTypeDate
		description: "Date of ship out"
		required:    true
	}
	createdAt: tailordb.#CreatedAtField
}
