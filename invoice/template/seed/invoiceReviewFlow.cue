package invoiceReviewFlow

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGraphqlSeed
	spec:    manifest.#SpecGraphqlSeed & {
		mutations: [
			{
				query: """
				mutation ($states: [StateTransitionModelInput!]!, $id: ID) {
					newStateFlow(
					  input: {
						id: $id
						name: "invoiceReviewFlow"
						stateTransitionModels: $states
					  }
					) {
					  id
					}
				  }"""
				variables: {
					states: invoiceReviewFlow
					 id: {{ generateApplicationUUID "ReviewFlow1" | quote }}
				}
			},
		]
	}
}

invoiceReviewFlow: [
	{
		name: "ManagerReview"
		approvers: [{ id: {{ generateApplicationUUID "ManagerRole" | quote }} }]
		transitions: [{action: "approve", destination: "CustomerReview"}]
	},
	{
		name: "CustomerReview"
		approvers: [{ id: {{ generateApplicationUUID "CustomerRole" | quote }} }]
		transitions: [{action: "approve", destination: "AllApproved"}]
	},
	{
		name: "AllApproved"
	},
]
