package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"github.com/tailor-inc/platform-core-services/e2e/manifest/services/tailordb/type"
)

tailordb.#Spec & {
	namespace: "galaxy"
	types: [
		{type.Affiliation},
		{type.Species},
		{type.Role},
		{type.Episode},
		{type.Character},
	]
}
