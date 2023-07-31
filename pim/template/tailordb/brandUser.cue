package brandUser

import (
  "{{ .Values.cue.package }}/charts/common:permissions"
  "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
  "github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
  
	user: {
		type:         "User"
		sourceId:     "userID"
		_description: "The brand user"
	}
	userID: {
		type:        tailordb.#FieldTypeUUID
		description: "UserID"
		required:    true
		index:       true
    unique:      true
	}

  brandID: {
    type:        tailordb.#FieldTypeUUID
    description: "References the brand the user belongs to"
    required:    true
  }
  
  brandGroupID: {
    type:        tailordb.#FieldTypeUUID
    description: "References the group of the brand the user belongs to"
    required:    true
    index:       true
    unique:      true
  }

  brandName: {
    type:        tailordb.#FieldTypeString
    description: "The brand name of the user belongs to"
    required:    true
  }

}

BrandUser: tailordbv1.#TypeConfig & {
  fields:      _fields
  description: "Brand User model"
  permission:  permissions.employee
}