package state

import (
	"tailor.build/invoice/charts/common:permissions"
	 commonextends "tailor.build/invoice/charts/common:extends"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

State: tailordbv1.#TypeConfig & {
	extends:     true
	directives:  commonextends.directives
	description: "state model"
	permission:  permissions.strict
}
