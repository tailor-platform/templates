package product

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"sku": {
		type:        tailordb.#FieldTypeString
		description: "Product SKU"
		required:    true
	}
	"length": {
		type:        tailordb.#FieldTypeInteger
		description: "Length of the product"
		required:    true
	}
	"lotNum": {
		type:        tailordb.#FieldTypeString
		description: "Lot number of the material"
		required:    true
	}
	"productCategory": {
		type:        tailordb.#FieldTypeString
		description: "Category of the product"
	}
	"cutFrom": {
		type:        "Material"
		description: "The original material this product is cut from"
		sourceId:    "cutFromId"
	}
	"cutFromId": {
		type:        tailordb.#FieldTypeUUID
		description: "The ID of the original material this product is cut from"
		foreignKey:      true
		foreignKeyType:  "Material"
	}
	"uom": {
		type:        tailordb.#FieldTypeString
		description: "Unit of measurement of the product, e.g. sheet, roll, etc."
	}
	"pricePerUnit": {
		type:        tailordb.#FieldTypeInteger
		description: "Price per unit"
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Quantity of the product"
	}

}

Product: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Product model"
	permission:  permissions.employee
	settings: {
		bulkUpsert:  true
		versioning:  true
		aggregation: true
	}
	indexes:{
		"productIndex":{
			fieldNames: ["sku", "lotNum", "length"]
			unique:     true
		}
	}
}
