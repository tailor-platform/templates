package product

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGraphqlSeed
	spec:    manifest.#SpecGraphqlSeed & {
		mutations: mutationList
	}
}

let mutationList = [
	for k, v in materials {
		{
			query: """
			mutation cutMaterial($id:ID!, $cutLength:Float! $isScrap:Boolean) {
				  cutMaterial(input:{
				    id:$id
					cutLength:$cutLength
					isScrap	:$isScrap
			  })
			  {
				productId
				materialId
			  }
			}"""
			variables: {
				id:       v.id
				cutLength:      v.cutLength
				isScrap:      v.isScrap
			}
		}
	},
]

materials: {
	material1: {
		id:       {{ generateWorkspaceUUID "Material1" | quote }}
		cutLength:   2.5
		isScrap: true
	}

}
