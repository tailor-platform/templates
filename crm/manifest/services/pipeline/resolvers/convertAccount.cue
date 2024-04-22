package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

convertAccount: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "convertAccount"
	Description: "convert a Lead to an Account"
	Response: { Type: pipeline.Boolean }
    PostScript: "context.pipeline.deleteLead"
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "calculateDocumentInput"
				Fields: [
					{Name: "companyName", Type: pipeline.String, Required:  true},
					{Name: "leadID", Type: pipeline.ID, Required:  true},
					{Name: "emailAddress", Type: pipeline.String, Required:  false},
					{Name: "phoneNumber", Type: pipeline.String, Required:  false},
					{Name: "contactName", Type: pipeline.String, Required:  false},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "createsAccount"
			Description: "creates a new Account"
			Invoker:     settings.adminInvoker
			PreScript:   """
				{
					'companyName': context.args.input.companyName,
					'leadID': context.args.input.leadID,
					'emailAddress': context.args.input.emailAddress,
					'phoneNumber': context.args.input.phoneNumber,
					'contactName': context.args.input.contactName
				}"""
			Operation: pipeline.#GraphqlOperation & {
                    Query: """
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
			}
			PostScript: "args.createCustomerAccount"
		},
		{
			Name:        "deleteLead"
			Description: "delete a lead"
			PreScript:   """
				{
					'leadID': context.args.input.leadID
				}"""
			Operation: pipeline.#GraphqlOperation & {
                    Query: """
					mutation ($leadID: ID!) {
						deleteLead(id: $leadID)
					}"""
			}
			PostScript: "args.deleteLead"
		},
	]
}
