package pipelines

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"{{ .Values.cue.package }}/charts/pipeline/resolvers"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   {{ .Values.pipeline.namespace | quote }}
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
