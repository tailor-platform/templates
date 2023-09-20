package pipelines

import (
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/directory:directories"
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/pipeline/resolvers"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   "alascop-process-mgmt-demo-ntldvzkd"
	invoker:     directories.roleMap.Admin.id
	description: "pipeline resolver"
	sdl: """
  input cutMaterialInput {
    id: ID!
    cutLength: Float!
    isScrap: Boolean
  }
  type cutMaterialResult {
    productId: ID
    materialId: ID
  }



  type Mutation {
    cutMaterial(input: cutMaterialInput): cutMaterialResult

  }
  """
	resolverMap: {
		"cutMaterial":       resolvers.cutMaterial
	}
}
