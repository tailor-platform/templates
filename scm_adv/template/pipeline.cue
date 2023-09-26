package pipeline

import (
	specmanifest "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"{{ .Values.cue.package }}/charts/pipeline:pipelines"
)

specmanifest.#TailorManifest & {
	version: "v1"
	kind:    specmanifest.#KindPipeline
	spec:    specmanifest.#SpecPipeline & {
		namespace: {
			name: {{ .Values.pipeline.namespace | quote }}
		}
		manifest: pipelines.pipeline
	}
}
