package tailordb

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb:invoice"
	"{{ .Values.cue.package }}/charts/tailordb:state"
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
					name:  "Invoice"
					schema: invoice.Invoice
				},
				{
					name:  "State"
					schema: state.State
				},
				]
	}
}
