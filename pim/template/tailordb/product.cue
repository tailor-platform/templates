package product

import (
  "{{ .Values.cue.package }}/charts/common:permissions"
  "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
  "github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {

  brandID: {
    type:        tailordb.#FieldTypeUUID
    description: "ID of the brand that owns the product"
    required:    true
  }
  categoryID: {
    type:        tailordb.#FieldTypeUUID
    description: "ID of the category that the product belongs to"
  }
  attributeID: {
    type:        tailordb.#FieldTypeUUID
    description: "ID of the attribute that the product belongs to"
  }
  productName: {
    type:        tailordb.#FieldTypeString
    description: "Name of the product"
    required:    true
  }
  productDescription: {
    type:        tailordb.#FieldTypeString
    description: "Description of the product"
    required:    true
  }
  productImage: {
    type:        tailordb.#FieldTypeString
    description: "Image or URL representing the product"
  }
  productPrice: {
    type:        tailordb.#FieldTypeFloat
    description: "Price of the product"
  }
  availability: {
    type:        tailordb.#FieldTypeEnum
    description: "Current stock availability of the product"
    values:     ["IN_STOCK", "OUT_OF_STOCK"]
  }
  availableQuantity: {
    type:        tailordb.#FieldTypeInteger
    description: "Current available quantity of the product"
  }
  otherDetails: {
    type:        tailordb.#FieldTypeString
    description: "Other relevant product details"
  }
}

Product: tailordbv1.#TypeConfig & {
  fields:      _fields
  description: "Product model"
  permission:  permissions.employee
}