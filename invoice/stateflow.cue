package stateflow

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/stateflow/v1:stateflowv1"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindStateFlow
	spec:    manifest.#SpecStateFlow & {
		namespace: stateflowv1.#Namespace & {
			name: {{ .Values.stateflow.namespace | quote }}
			admins: [directories.roleMap.Admin.id, directories.roleMap.Staff.id, directories.roleMap.Manager.id]
		}
	}
}