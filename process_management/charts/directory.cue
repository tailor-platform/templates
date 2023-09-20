package directory

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/directory:directories"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindDirectorySeed
	spec:    manifest.#SpecDirectorySeed & {
		id: "90539ae8-6084-4c04-a2a4-0691df9382ab" @ignoreChange()
		roleClasses: directories.roleClassList
		policies:    directories.policyList
		roles:       directories.roleList
		groups:      directories.groupList
		userTypes:   directories.userTypeList
		users:       directories.userList
	}
}
