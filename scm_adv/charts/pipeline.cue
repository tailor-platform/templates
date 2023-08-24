package pipeline

import (
	specmanifest "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"tailor.build/scm-adv-cygfedck/charts/pipeline:pipelines"
)

specmanifest.#TailorManifest & {
	version: "v1"
	kind:    specmanifest.#KindPipeline
	spec:    specmanifest.#SpecPipeline & {
		namespace: {
			name: "scm-adv-cygfedck"
		}
		manifest: pipelines.pipeline
	}
}
