package gateway

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/gateway/v1:gatewayv1"
	appmanifest "tailor.build/crm/manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGateway
	spec:    gatewayv1.#Domain & {
		name: appmanifest.#app.domain 
		cors: [
			"https://*.tailor.business",
			"http://localhost:3000",
			"https://*.vercel.app",
		]
		defaultTimezone: "UTC"
		subgraph: [
			{
				name: "tailordb"
				url:  appmanifest.#subgraph.tailordb
			},
			{
				name: "pipeline"
				url:  appmanifest.#subgraph.pipeline
			},
		]
	}
}
