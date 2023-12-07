package product

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"code": {
		type:        tailordb.#FieldTypeInteger
		description: "product code."
	}
	"name": {
		type:        tailordb.#FieldTypeString
		description: "Name of the product."
	}
	"description": {
		type:        tailordb.#FieldTypeString
		description: "Description of the product."
	}
	"price": {
		type:        tailordb.#FieldTypeFloat
		description: "Price of the product."
	}
	"uom": {
		type:        tailordb.#FieldTypeString
		description: "Unit of measure of the product."
	}
	"sellingStartDate": {
		type:		tailordb.#FieldTypeDate
		description: "The date this product starts selling. This field is used to calculate the sales velocity used for demand forecasting."
	}
}

Product: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Product model"
	permission:  permissions.#AllowEveryone
}
