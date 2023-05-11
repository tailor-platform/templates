package tailordb

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb:employee"
	"{{ .Values.cue.package }}/charts/tailordb:employment"
	"{{ .Values.cue.package }}/charts/tailordb:personalData"
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