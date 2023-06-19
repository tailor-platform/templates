package product

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"productName": {
		type:        tailordb.#FieldTypeString
		description: "product name."
	}
	"productCode": {
		type:        tailordb.#FieldTypeInteger
		description: "product code."
	}
	"productCategory": {
		type:        tailordb.#FieldTypeString
		description: "category of the product"
	}
	"eanCode": {
		type:        tailordb.#FieldTypeString
		description: "EAN code of the product"
	}
	"uom": {
		type:        tailordb.#FieldTypeString
		description: "Unit of measurement of the product. E.g, sheet, roll, etc."
	}
	"pricePerUnit": {
		type:        tailordb.#FieldTypeFloat
		description: "Price per unit."
	}

}

Product: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Product model"
	permission:  permissions.employee
}
