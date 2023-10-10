package directory

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"tailor.build/hris/charts/directory:directories"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindDirectorySeed
	spec:    manifest.#SpecDirectorySeed & {
		id: {{ generateUUID | quote }} @ignoreChange()
		roleClasses: directories.roleClassList
		policies:    directories.policyList
		roles:       directories.roleList
		userTypes:   directories.userTypeList
		users:       directories.userList
	}
}
