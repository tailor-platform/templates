package pipelines

import (
	"tailor.build/crm/charts/directory:directories"
    "tailor.build/crm/charts/pipeline/resolvers"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   {{ .Values.pipeline.namespace | quote }}
	invoker:     directories.roleMap.Admin.id
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
