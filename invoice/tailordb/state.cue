package state

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	 commonextends "{{ .Values.cue.package }}/charts/common:extends"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

State: tailordbv1.#TypeConfig & {
	extends:     true
	directives:  commonextends.directives
	description: "state model"
	permission:  permissions.strict
}
