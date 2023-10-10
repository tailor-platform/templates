package tailordb

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"tailor.build/client-portal/charts/tailordb:client"
	"tailor.build/client-portal/charts/tailordb:invoice"
	"tailor.build/client-portal/charts/tailordb:request"
	"tailor.build/client-portal/charts/tailordb:user"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindTailorDB
	spec:    manifest.#SpecTailorDB & {
		namespace: tailordbv1.#Namespace & {
			name:            {{ .Values.tailordb.namespace | quote }}
			defaultTimezone: "UTC"
		}
		manifests: [...tailordbv1.#Manifest] &
			[
				{
					name:   "Client"
					schema: client.Client
				},
				{
					name:   "Invoice"
					schema: invoice.Invoice
				},
				{
					name:   "Request"
					schema: request.Request
				},
				{
					name:   "User"
					schema: user.User
				},
			]
	}
}
