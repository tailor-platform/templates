package directory

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"tailor.build/scm-pxxmksnj/charts/directory:directories"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindDirectorySeed
	spec:    manifest.#SpecDirectorySeed & {
		id: "6b91e841-abd8-4e8f-bc54-d0a5221c339c" @ignoreChange()
		roleClasses: directories.roleClassList
		policies:    directories.policyList
		roles:       directories.roleList
		groups:      directories.groupList
		userTypes:   directories.userTypeList
		users:       directories.userList
	}
}
