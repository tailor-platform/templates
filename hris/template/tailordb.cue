package tailordb

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"tailor.build/hris/charts/tailordb:employee"
	"tailor.build/hris/charts/tailordb:employment"
	"tailor.build/hris/charts/tailordb:personalData"
	"tailor.build/hris/charts/tailordb:user"

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
					name:  "Employee"
					schema: employee.Employee
				},
				{
					name:  "Employment"
					schema: employment.Employment
				},
				{
					name:  "PersonalData"
					schema: personalData.PersonalData
				},
				{
					name:  "User"
					schema: user.User
				},
			]
	}
}
