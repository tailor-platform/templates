package product

import (
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"productName": {
		type:        tailordb.#FieldTypeString
		description: "Product name"
		required:    true
	}
	"productCode": {
		type:        tailordb.#FieldTypeString
		description: "Product code"
		required:    true
	}
	"length": {
		type:        tailordb.#FieldTypeFloat
		description: "Length of the product"
		required:    true
	}
	"productCategory": {
		type:        tailordb.#FieldTypeString
		description: "Category of the product"
	}
	"cutFrom": {
		type:        "Material"
		description: "The original material that generates this product"
		sourceId:    "cutFromId"
	}
	"cutFromId": {
		type:        tailordb.#FieldTypeUUID
		description: "The original material id that generates this product"
		foreignKey:      true
		foreignKeyType:  "Material"
	}
	"uom": {
		type:        tailordb.#FieldTypeString
		description: "Unit of measurement of the product, e.g. sheet, roll, etc."
	}
	"pricePerUnit": {
		type:        tailordb.#FieldTypeFloat
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
}
