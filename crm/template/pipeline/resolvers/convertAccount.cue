package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

convertAccountInput: {
	name: "convertAccountInput"
	fields: [
		{ name: "companyName",  type: schema.String, required: true },
		{ name: "leadID",       type: schema.ID, required: true },
		{ name: "emailAddress", type: schema.String },
		{ name: "phoneNumber",  type: schema.String },
		{ name: "contactName",  type: schema.String },
	]
}

convertAccount: pipelinev1.#Resolver & {
	authorization: "true"
	id:			 {{generateUUID | quote}}
	name:        "convertAccount"
	description: "convert a Lead to an Account"
	inputs: [
		{ name: "input", type:convertAccountInput },
	]
	response: { type: schema.Boolean }
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "createsAccount"
			description: "creates a new Account"
			url:         settings.services.gateway
			preScript:   "context.args.input"
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
			id: {{generateUUID | quote}}
			name:        "deleteLead"
			description: "delete a lead"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
			mutation ($leadID: ID!) {
				deleteLead(id: $leadID)
			}"""
			postScript: "args.deleteLead"
		},
	]
}
