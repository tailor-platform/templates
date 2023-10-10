package stateflow

import (
	"tailor.build/todo-app-stateflow/charts/directory:directories"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/stateflow/v1:stateflowv1"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindStateFlow
	spec:    manifest.#SpecStateFlow & {
		namespace: stateflowv1.#Namespace & {
			name: {{ .Values.stateflow.namespace | quote }}
			admins: [directories.roleMap.Admin.id]
		}
	}
}
