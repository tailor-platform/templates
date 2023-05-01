package employee

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"user": {
		type:        "User"
		description: "Directory User data for this employee"
		sourceId:    "userID"
	}
	"userID": {
		type:        "tailordb.#FieldTypeUUID"
		description: "Directory User data for this employee"
	}
}

Employee: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Employee model"
	permission:  permissions.employee
}
