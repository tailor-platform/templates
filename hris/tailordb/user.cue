package user

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	commonextends "{{ .Values.cue.package }}/charts/common:extends"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

User: tailordbv1.#TypeConfig & {
	extends:     true
	directives:  commonextends.directives
	description: "employee's user data"
	permission:  permissions.employee
	fields: {
		"username": {
			type:        tailordb.#FieldTypeString
			description: "username"
		}
	}
}
