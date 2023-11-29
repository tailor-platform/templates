package replenishmentAlert

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

ReplenishmentAlert: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Replenishment alert"
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
	"daysToStockout": {
		type:        tailordb.#FieldTypeFloat
		description: "Days to stockout."
	}
	"maxLeadTime": {
		type:        tailordb.#FieldTypeFloat
		description: "Max lead time."
	}
	"expectedDaysForNextOrder": {
		type:        tailordb.#FieldTypeFloat
		description: "Expected days for next order."
		hooks: {
			createExpr: "ifThen (_value.daysToStockout != null, _value.daysToStockout + _value.maxLeadTime)"
			updateExpr: "ifThen (_value.daysToStockout != null, _value.daysToStockout + _value.maxLeadTime)"
		}
	}



	createdAt: tailordb.#CreatedAtField
	updatedAt: tailordb.#UpdatedAtField
}
