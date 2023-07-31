package attribute

import (
  "{{ .Values.cue.package }}/charts/common:permissions"
  "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
  "github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
  productID: {
    type:        tailordb.#FieldTypeUUID
    description: "ID of the product to which this attribute belongs."
  }
  attributeName: {
    type:        tailordb.#FieldTypeString
    description: "Name of the attribute (e.g., Size, Color, Weight)."
  }
  attributeType: {
    type:        tailordb.#FieldTypeString
    description: "Type of attribute (e.g., text, numeric, dropdown)."
  }
  otherDetails: {
    type:        tailordb.#FieldTypeString
    description: "Other relevant attribute details."
  }
}

Attribute: tailordbv1.#TypeConfig & {
  fields:      _fields
  description: "Attribute model"
  permission:  permissions.employee
}