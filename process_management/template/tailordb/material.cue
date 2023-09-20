package material

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"materialName": {
		type:        tailordb.#FieldTypeString
		description: "Material name"
		required:    true
	}
	"materialCode": {
		type:        tailordb.#FieldTypeString
		description: "Material code"
		required:    true
	}
	"length": {
		type:        tailordb.#FieldTypeFloat
		description: "Length of the material"
		required:    true
	}
	"width": {
		type:        tailordb.#FieldTypeFloat
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
		type:        tailordb.#FieldTypeFloat
		description: "Price per unit"
	}
	"quantity": {
		type:        tailordb.#FieldTypeInteger
		description: "Quantity of the material"
	}
	"isScrap": {
		type:        tailordb.#FieldTypeBool
		description: "If true, this is managed as a scrap which is no longer used for production."
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
}
