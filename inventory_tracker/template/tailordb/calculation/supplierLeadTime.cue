package supplierLeadTime

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

SupplierLeadTime: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Model for Put Away. Putting away means receiving and storing goods to a location. This model takes PurchaseOrder as a foreign key. Each PurchaseOrder can have multiple PutAway."
	permission:  permissions.#AllowEveryone
	settings: {
		aggregation: true
	}
}

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"productID": {
		type:        tailordb.#FieldTypeUUID
		description: "Product ID"
		required:    true
	}
	"product": {
		type:        "Product"
		description: "Product model"
		sourceId:    "productID"
	}
	"locationID": {
		type:        tailordb.#FieldTypeUUID
		description: "Location ID"
		required:    true
	}
	"location": {
		type:        "Location"
		description: "Location model"
		sourceId:    "locationID"
	}
	"supplierID": {
		type:        tailordb.#FieldTypeUUID
		description: "Supplier ID"
		required:    true
	}
	"supplier": {
		type:        "Supplier"
		description: "Supplier model"
		sourceId:    "supplierID"
	}
	"averageLeadTime": {
		type:        tailordb.#FieldTypeFloat
		description: "Lead time"
		required:    false
	}

	createdAt: tailordb.#CreatedAtField
	updatedAt: tailordb.#UpdatedAtField
}
