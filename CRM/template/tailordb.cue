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
			organizationId:  {{ generateUUID | quote }}
			defaultTimezone: "UTC"
		}
		manifests: [...tailordbv1.#Manifest] &
			[
				{
					table:  "CustomerAccount"
					schema: customerAccount.CustomerAccount
				},
				{
					table:  "Engagement"
					schema: engagement.Engagement
				},
				{
					table:  "Lead"
					schema: lead.Lead
				},
				{
					table:  "Transaction"
					schema: transaction.Transaction
				},
			]
	}
}
