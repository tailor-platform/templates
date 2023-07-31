package brand

import (
  "{{ .Values.cue.package }}/charts/common:permissions"
  "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
  "github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {

  // "brandUserID": {
  //   type:        tailordb.#FieldTypeUUID
  //   description: "ID of the brand user."
  //   index:       true
	// 	unique:      true
  // }

  brandGroupID: {
    type:        tailordb.#FieldTypeUUID
    description: "ID of the brand user."
    index:       true
		unique:      true
    required:    true
  }

  brandName: {
    type:        tailordb.#FieldTypeString
    description: "Name of the brand"
    required:    true
  }
  brandLogo: {
    type:        tailordb.#FieldTypeString
    description: "Logo of the brand (image or URL)"
  }
  brandDescription: {
    type:        tailordb.#FieldTypeString
    description: "Brief description of the brand"
    required:    true
  }
  contactInformation: {
    type:        tailordb.#FieldTypeString
    description: "Contact details of the brand (address, email, phone)"
  }
}

Brand: tailordbv1.#TypeConfig & {
  fields:      _fields
  description: "Brand model"
  permission:  permissions.employee
}