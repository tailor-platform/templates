package stockEventCalc

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb:stockEvent" // import stockEvent since this model extends it
)

StockEventCalc: tailordbv1.#TypeConfig & {
	fields:      stockEvent.StockEvent.fields & _additionalFields
	description: "Intermediate calculating table of StockEvent. Flattens Lot, PutAway, PurchaseOrder, Product, Location, and StockEvent."
	permission:  permissions.#AllowEveryone
	settings: {
		aggregation: true
	}
}

_additionalFields: {[string]: tailordbv1.#FieldConfig} & {
	"stockEventID": {
		type:        tailordb.#FieldTypeUUID
		description: "Stock event ID"
		required:    true
	}
	"putAwayID": {
		type:        tailordb.#FieldTypeUUID
		description: "PutAway ID"
		required:    true
	}
	"purchaseOrderID": {
		type:        tailordb.#FieldTypeUUID
		description: "purchaseOrder ID"
		required:    true
	}
	"productID": {
		type:        tailordb.#FieldTypeUUID
		description: "Product ID"
		required:    true
	}
	"locationID": {
		type:        tailordb.#FieldTypeUUID
		description: "Location ID"
		required:    true
	}
	"sellingStartDate": {
		type:		tailordb.#FieldTypeDate
		description: "Selling start date. Attribute of Product"
	}
	updatedAt: tailordb.#UpdatedAtField
}
