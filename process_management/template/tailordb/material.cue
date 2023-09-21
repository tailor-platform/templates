package material

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"sku": {
		type:        tailordb.#FieldTypeString
		description: "Material SKU"
		required:    true
	}
	"lotNum": {
		type:        tailordb.#FieldTypeString
		description: "Lot number of the material"
		required:    true
	}
	"length": {
		type:        tailordb.#FieldTypeInteger
		description: "Length of the material"
		required:    true
	}
	"width": {
		type:        tailordb.#FieldTypeInteger
		description: "Width of the material"
	}
	"materialCategory": {
		type:        tailordb.#FieldTypeString
		description: "Category of the material"
	}
	"uom": {
		type:        tailordb.#FieldTypeString
		description: "Unit of measurement of the material, e.g. sheet, roll, etc."
	}
	"pricePerUnit": {
		type:        tailordb.#FieldTypeInteger
		description: "Price per unit"
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Quantity of the material"
	}
	"isScrap": {
		type:        tailordb.#FieldTypeBool
		description: "Whether the material is a scrap. If true, it shouldn't be used for production."
		defaultValue: {
			boolValue: false
		}
	}
}

Material: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Material model"
	permission:  permissions.employee
	settings: {
		bulkUpsert:  true
		versioning:  true
		aggregation: true
	}
	indexes:{
		"materialIndex":{
			fieldNames: ["sku", "lotNum", "length"]
			unique:     true
		}
	}
}
