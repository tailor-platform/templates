package gateway

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/gateway/v1:gatewayv1"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGateway
	spec:    gatewayv1.#Domain & {
		name: {{ .Values.gateway.domain | quote }}
		cors: [
			"https://*.tailor.business",
			"http://localhost:3000",
			"https://*.vercel.app",
		]
		defaultTimezone: "UTC"
		subgraph: [
			{
				name: "directory"
				url: {{ .Values.directory.graphqlEndpoint | quote }}
			},
			{
				name: "tailordb"
				url: {{ .Values.tailordb.graphqlEndpoint | quote }}
			},
			{
				name: "pipeline"
				url:  {{ .Values.pipeline.graphqlEndpoint | quote }}
			},
		]
	}
}
