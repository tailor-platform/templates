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
			organizationId:  {{ generateUUID | quote }}
			defaultTimezone: "UTC"
		}
		manifests: [...tailordbv1.#Manifest] &
			[
				{
					table:  "Client"
					schema: client.Client
				},
				{
					table:  "Invoice"
					schema: invoice.Invoice
				},
				{
					table:  "Request"
					schema: request.Request
				},
				{
					table:  "User"
					schema: user.User
				},
			]
	}
}
