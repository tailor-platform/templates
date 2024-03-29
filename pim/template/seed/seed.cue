package graphqlseed

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
	for k, v in brands {
			{
				query: """
                mutation ($brandName: String!, $brandDescription: String!) {
                      addBrand(
                        input: {brandName: $brandName, brandDescription: $brandDescription}
                  )
                }"""
				variables: {
					brandName: v.name
					brandDescription: v.description
				}
			},

	},
]

brands: {
	brand1: {
		id:    {{ generateApplicationUUID "brandA" | quote }}
		name:     "BrandA"
		description: "Brand A"
	}
	brand2: {
		id:    {{ generateApplicationUUID "brandB" | quote }}
		name:     "BrandB"
		description: "Brand B"
	}
}
