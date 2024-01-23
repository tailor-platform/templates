package pipeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-inc/platform-core-services/e2e/manifest/services/pipeline/query"
)

pipeline.#Spec & {
	namespace: "starwars"
	resolvers: [
		query.GetHeros,
	]
}
