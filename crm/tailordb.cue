package tailordb

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb:customerAccount"
	"{{ .Values.cue.package }}/charts/tailordb:engagement"
	"{{ .Values.cue.package }}/charts/tailordb:lead"
	"{{ .Values.cue.package }}/charts/tailordb:transaction"
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
					name:  "CustomerAccount"
					schema: customerAccount.CustomerAccount
				},
				{
					name:  "Engagement"
					schema: engagement.Engagement
				},
				{
					name:  "Lead"
					schema: lead.Lead
				},
				{
					name:  "Transaction"
					schema: transaction.Transaction
				},
			]
	}
}
