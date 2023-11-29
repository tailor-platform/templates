package salesOrder

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

SalesOrder: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Model for Sales Order. Each record of the Sales Order should specify a lot. Customization is required to wrap multiple records (line items) into one purchase order."
	permission:  permissions.#AllowEveryone
	settings: {
		aggregation: true
	}
}

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"lot": {
		type:        "Lot"
		description: "Lot. Each record of the Sales Order should specify a lot for tracability purpose"
		sourceId:    "lotID"
	}
	"lotID": {
		type:        tailordb.#FieldTypeUUID
		description: "Lot ID"
		required:    true
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Order quantity"
		required:    true
	}
	"salesOrderDate": {
		type:        tailordb.#FieldTypeDate
		description: "Date of sales order"
		required:    true
	}
	"customerName": {
		type:        tailordb.#FieldTypeString
		description: "Customer name"
		required:    false
	}
	"deliveryAddress": {
		type:        tailordb.#FieldTypeString
		description: "Delivery address of the customer"
		required:    false
	}
	createdAt: tailordb.#CreatedAtField
}
