package directory

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"{{ .Values.cue.package }}/charts/directory:directories"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindDirectorySeed
	spec:    manifest.#SpecDirectorySeed & {
		id: {{ generateUUID | quote }} @ignoreChange()
		roleClasses: directories.roleClassList
		policies:    directories.policyList
		roles:       directories.roleList
		users:       directories.userList
	}
}
