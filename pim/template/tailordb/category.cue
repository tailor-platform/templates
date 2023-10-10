package category

import (
  "tailor.build/pim/charts/common:permissions"
  "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
  "github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
  productID: {
    type:        tailordb.#FieldTypeUUID
    description: "ID of the product to which this attribute belongs."
  }
  categoryName: {
    type:        tailordb.#FieldTypeString
    description: "Name of the category"
  }
  categoryDescription: {
    type:        tailordb.#FieldTypeString
    description: "Description of the category"
  }
  otherDetails: {
    type:        tailordb.#FieldTypeString
    description: "Other relevant category details"
  }
}

Category: tailordbv1.#TypeConfig & {
  fields:      _fields
  description: "Category model"
  permission:  permissions.employee
}