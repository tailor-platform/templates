package invoiceReviewFlow

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"{{ .Values.cue.package }}/charts/common:constant"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGraphqlSeed
	spec:    manifest.#SpecGraphqlSeed & {
		mutations: [
      {
        query: """
		mutation (
			$states: [StateTransitionModelInput!]!
			$id: ID
		  ) {
			newStateFlow(
			  input: {
				id: $id
				name: "invoiceReviewFlow"
				stateTransitionModels: $states
			  }
			) {
			  id
			}
		  }
"""
        variables: {
		  states: invoiceReviewFlow
		  id: constant.uuid & {_, #type: "reviewFlow", #value: "1"}
        }
      },
    ]
    
	}
}

invoiceReviewFlow: [
        {
          name: "ManagerReview"
          approvers: [{ id: constant.uuid & {_, #type: "role", #value: "manager"} }]
          transitions: [{ action: "approve", destination: "CustomerReview" }]
        },
        {
          name: "CustomerReview"
          approvers: [{ id: constant.uuid & {_, #type: "role", #value: "customer"} }]
          transitions: [{ action: "approve", destination: "AllApproved" }]
        },
        {
          name: "AllApproved"
        }
]

