package purchaseOrder

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

PurchaseOrder: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Model for Purchase Order. Each record of the Purchase Order represents unique combination of a Product, a Location, and a Supplier. Customization is required to wrap multiple records (line items) into one purchase order."
	permission:  permissions.#AllowEveryone
	settings: {
		aggregation: true
	}
}

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"product": {
		type:        "Product"
		description: "Product. This field constitutes a unique key with location"
		sourceId:    "productID"
	}
	"productID": {
		type:        tailordb.#FieldTypeUUID
		description: "Product ID"
		required:    true
	}
	"location": {
		type:        "Location"
		description: "Location. This field constitutes a unique key with product"
		sourceId:    "locationID"
	}
	"locationID": {
		type:        tailordb.#FieldTypeUUID
		description: "Location ID"
		required:    true
	}
	"supplier": {
		type:        "Supplier"
		description: "Supplier. This field constitutes a unique key with product"
		sourceId:    "supplierID"
	}
	"supplierID": {
		type:        tailordb.#FieldTypeUUID
		description: "Supplier ID"
		required:    true
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Order quantity"
		required:    true
	}
	"purchaseOrderDate": {
		type:        tailordb.#FieldTypeDate
		description: "Date of purchase order"
		required:    true
	}
	createdAt: tailordb.#CreatedAtField
}
