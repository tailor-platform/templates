package pipeline

import (
	specmanifest "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/pipeline:pipelines"
)

specmanifest.#TailorManifest & {
	version: "v1"
	kind:    specmanifest.#KindPipeline
	spec:    specmanifest.#SpecPipeline & {
		namespace: {
			name: "alascop-process-mgmt-demo-ntldvzkd"
		}
		manifest: pipelines.pipeline
	}
}
