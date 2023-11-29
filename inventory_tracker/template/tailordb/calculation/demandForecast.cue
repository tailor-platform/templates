package demandForecast

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

DemandForecast: tailordbv1.#TypeConfig & {
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
	"sellingStartDate": {
		type:		tailordb.#FieldTypeDate
		description: "The date this product starts selling. This field is used to caluculate the sales velocity used for demand forecasting."
	}
	"today": {
		type:        tailordb.#FieldTypeDate
		description: "The date of the calculation"
		hooks: {
			createExpr: "date(today())"
			updateExpr: "date(today())"
		}
	}
	"dailyDemand": {
		type:        tailordb.#FieldTypeFloat
		description: "Daily demand."
		hooks: {
			createExpr: "decimal(_value.sumOfIncrementalQuantity) / decimal((date(today()) - date(_value.sellingStartDate)).getHours()/24)"
			updateExpr: "decimal(_value.sumOfIncrementalQuantity) / decimal((date(today()) - date(_value.sellingStartDate)).getHours()/24)"
		}
	}

	createdAt: tailordb.#CreatedAtField
	updatedAt: tailordb.#UpdatedAtField
}
