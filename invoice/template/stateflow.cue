package stateflow

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindStateFlow
	spec:    manifest.#SpecStateFlow & {
		id: {{ generateUUID | quote }}
		name: {{ .Values.stateflow.namespace | quote }}
		admins: [directories.roleMap.Admin.id, directories.roleMap.Staff.id, directories.roleMap.Manager.id]
	}
}
