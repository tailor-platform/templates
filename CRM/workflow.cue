package pipeline

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindWorkflow
	spec:    manifest.#SpecWorkflow & {
		id: {{ .Values.organization.id | quote }}
		workflowAdmins: [directories.userList[0].id]
	}
}
