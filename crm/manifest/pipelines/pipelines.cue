package pipelines

import (
	appmanifest "tailor.build/crm/manifest"
	"tailor.build/crm/manifest/pipelines/resolvers"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   appmanifest.#app.namespace 
	description: "CRM pipeline resolver"
	sdl: """
		type Mutation {
			convertAccount(
			companyName: String!
			leadID: ID!
			emailAddress: String
			phoneNumber: String
			contactName: String): Boolean
		}
		"""
	resolverMap: {
		"convertAccount": resolvers.convertAccount,
	}
}
