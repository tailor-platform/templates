package user

import (
	"tailor.build/client-portal/charts/common:permissions"
	commonextends "tailor.build/client-portal/charts/common:extends"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

User: tailordbv1.#TypeConfig & {
	extends:     true
	directives:  commonextends.directives
	description: "user model"
	permission:  permissions.loggedinUser
}
