package user

import (
	"tailor.build/hris/charts/common:permissions"
	commonextends "tailor.build/hris/charts/common:extends"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

User: tailordbv1.#TypeConfig & {
	extends:     true
	directives:  commonextends.directives
	description: "employee's user data"
	permission:  permissions.employee
}
