package pipelines

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"{{ .Values.cue.package }}/charts/pipeline/resolvers"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   {{ .Values.pipeline.namespace | quote }}
	invoker:     directories.roleMap.Admin.id
	description: "HRIS pipeline resolver"
	sdl: """

	input addBrandUserInput {
		displayName: String!
		username: String!
		secret: String!
		roleInput: [ids!]
		groupInput: [ids!]
		userID: ID
		brandID: ID!
		brandName: String!
	}
	type addBrandUserResult {
		id: ID
	}
	input ids {
		id: ID!
	}
	input addBrandProductInput {
		productName: String!
		productDescription: String!
		brandID: ID!
	}
	type addBrandProductResult {
		id: ID
	}

	input addBrandInput {
		brandName: String!
		brandDescription: String!
	}
	type addBrandResult {
		id: ID
	}
	
	type Mutation {
		addBrand(input: addBrandInput!): addBrandResult
		addBrandUser(input: addBrandUserInput!): addBrandUserResult
		addBrandProduct(input: addBrandProductInput!): addBrandProductResult
	}"""
	resolverMap: {
		"addBrand":            resolvers.addBrand
		"addBrandUser":        resolvers.addBrandUser
		"addBrandProduct":  resolvers.addBrandProduct
	}
}
