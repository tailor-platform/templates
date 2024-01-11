package pipeline

import (
	specmanifest "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	appmanifest "tailor.build/crm/manifest"
	"tailor.build/crm/manifest/pipelines"
)

specmanifest.#TailorManifest & {
	version: "v1"
	kind:    specmanifest.#KindPipeline
	spec:    specmanifest.#SpecPipeline & {
		namespace: {
			name: appmanifest.#app.namespace 
		}
		manifest: pipelines.pipeline
	}
}
