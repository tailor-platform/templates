package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"
)

convertAccount: pipelinev1.#Resolver & {
	id:          {{ generateUUID | quote }}
	name:        "convertAccount"
	description: "convert a Lead to an Account"
	pipeline: [
		{
			id:          {{ generateUUID | quote }}
			name:        "createsAccount"
			description: "creates a new Account"
			url:         settings.services.db
			preScript:   "context.args"
			graphqlQuery: """
				  		mutation(
					    	$companyName: String!
					    	$leadID: ID!
							$emailAddress: String
				  			$phoneNumber: String
							$contactName: String
					  		) {
				    	createCustomerAccount(input: {
				      		companyName: $companyName,
				      		leadID: $leadID,
				        contact: {
							emailAddress: $emailAddress
				  			phoneNumber: $phoneNumber
							contactName: $contactName
				  			},
				    	}) {
				        id
				    	}
				  	}
"""
			postScript: "args.createCustomerAccount"
		},
		{
			id:          {{ generateUUID | quote }}
			name:        "deleteLead"
			description: "delete a lead"
			url:         settings.services.db
			preScript:   "context.args"
			graphqlQuery:
				"""
				mutation ($leadID: ID!) {
					deleteLead(id: $leadID)
				}
"""
			postScript: "args"
		},
	]
}
