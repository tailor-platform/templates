package inventoryEvent

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"product": {
		type:        "Product"
		description: "product "
		sourceId:    "productCode"
	}
	"productCode": {
		type:        tailordb.#FieldTypeInteger
		description: "productID for this inventory record"
		foreignKey:      true
		foreignKeyType:  "Product"
		foreignKeyField: "productCode"		
	}
	"material": {
		type:        "Material"
		description: "material "
		sourceId:    "materialCode"
	}
	"materialCode": {
		type:        tailordb.#FieldTypeInteger
		description: "materialID for this inventory record"
		foreignKey:      true
		foreignKeyType:  "Material"
		foreignKeyField: "materialCode"		
	}
	"quantityDiff": {
		type:        tailordb.#FieldTypeInteger
		description: "delta of quantity. This value will be negative value if the event reduces inventory quantities"
		required:    true
	}
}

InventoryEvent: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "InventoryEvent model"
	permission:  permissions.employee
	settings: {
		bulkUpsert:  true
		versioning:  true
		aggregation: true
	}
}
