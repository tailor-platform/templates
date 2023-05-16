package tailordb

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb:client"
	"{{ .Values.cue.package }}/charts/tailordb:invoice"
	"{{ .Values.cue.package }}/charts/tailordb:request"
	"{{ .Values.cue.package }}/charts/tailordb:user"
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
