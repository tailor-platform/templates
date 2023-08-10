package gateway

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/gateway/v1:gatewayv1"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGateway
	spec:    gatewayv1.#Domain & {
		name: "scm-pxxmksnj.erp.dev"
		cors: [
			"https://*.tailor.business",
			"http://localhost:3000",
			"https://*.vercel.app",
		]
		defaultTimezone: "UTC"
		subgraph: [
			{
				name: "directory"
				url: "https://directory-v2/graph"
			},
			{
				name: "tailordb"
				url: "https://sldb/graphql/scm-pxxmksnj"
			},
		]
	}
}
