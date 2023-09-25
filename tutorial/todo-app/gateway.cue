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
			"https://*.tailor-console.pages.dev",
			"https://console.tailor.tech"
		]
		defaultTimezone: "UTC"
		subgraph: [

			// TailorDB service
			{
				name: "tailordb"
				url: {{ .Values.tailordb.graphqlEndpoint | quote }}
			},

			//      Directory service
			//      {
			//        name: "directory"
			//        url: {{ .Values.directory.graphqlEndpoint | quote }}
			//      },

			//      StateFlow service
			//      {
			//        name: "stateflow"
			//        url:  {{ .Values.stateflow.graphqlEndpoint | quote }}
			//      },

			//      Pipeline Service
			//      {
			//        name: "pipeline"
			//        url:  {{ .Values.pipeline.graphqlEndpoint | quote }}
			//      },
		]
	}
}
