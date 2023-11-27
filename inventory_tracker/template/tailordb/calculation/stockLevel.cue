package stockLevel

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

StockLevel: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Demand forecast"
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
	"sumOfIncrementalQuantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Sum of incremental quantity. "
		required:    true
	}
	"dailyDemand": {
		type:        tailordb.#FieldTypeFloat
		description: "Daily demand."
	}
	"daysToStockout": {
		type:        tailordb.#FieldTypeFloat
		description: "Days to stockout."
		hooks: {
			createExpr: "decimal(_value.sumOfIncrementalQuantity) / decimal(_value.dailyDemand)"
			updateExpr: "decimal(_value.sumOfIncrementalQuantity) / decimal(_value.dailyDemand)"
		}
	}

	createdAt: tailordb.#CreatedAtField
	updatedAt: tailordb.#UpdatedAtField
}
