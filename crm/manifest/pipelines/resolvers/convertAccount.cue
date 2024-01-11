package resolvers

import (
	appmanifest "tailor.build/crm/manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

convertAccount: pipelinev1.#Resolver & {
	authorization: "true"
	name:        "convertAccount"
	description: "convert a Lead to an Account"
	pipeline: [
		{
			name:        "createsAccount"
			description: "creates a new Account"
			url:        appmanifest.#subgraph.gateway 
			preScript:   "context.args"
			graphqlQuery: """
			mutation (
				$companyName: String!
				$leadID: ID!
				$emailAddress: String
				$phoneNumber: String
				$contactName: String
			  ) {
				createCustomerAccount(
				  input: {
					companyName: $companyName
					leadID: $leadID
					contact: {
					  emailAddress: $emailAddress
					  phoneNumber: $phoneNumber
					  contactName: $contactName
					}
				  }
				) {
				  id
				}
			  }"""
			postScript: "args.createCustomerAccount"
		},
		{
			name:        "deleteLead"
			description: "delete a lead"
			url:        appmanifest.#subgraph.gateway
			preScript:   "context.args"
			graphqlQuery: """
			mutation ($leadID: ID!) {
				deleteLead(id: $leadID)
			}"""
			postScript: "args.deleteLead"
		},
	]
}
