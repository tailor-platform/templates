package tailordb

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"tailor.build/crm/charts/tailordb:customerAccount"
	"tailor.build/crm/charts/tailordb:engagement"
	"tailor.build/crm/charts/tailordb:lead"
	"tailor.build/crm/charts/tailordb:transaction"
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
