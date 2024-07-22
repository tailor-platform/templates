package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/services/pipeline:settings"
)

createContactWithCompany: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "createContactWithCompany"
	Description: "Create a new Contact and Company"
	Response: {
		Type: {
			Name: "CreateContactWithCompanyOutput"
			Fields: [
				{ Name: "contactID", Type: pipeline.ID },
				{ Name: "companyID", Type: pipeline.ID },
			]
		}
	}
    PostScript: """
	{
		'contactID': get(context.pipeline.createContactStep.id),
		'companyID': get(context.pipeline.createCompanyStep.id)
	}"""
	Inputs: [
		{
			Name: "input"
			Required: true
			Type: {
				Name: "ContactWithCompanyCreateInput"
				Fields: [
					{ Name: "firstName", Type: pipeline.String, Required:  true},
					{ Name: "lastName", Type: pipeline.String },
					{ Name: "email", Type: pipeline.String, Required:  true},
					{ Name: "phonePrimary", Type: pipeline.String, Required:  true},
					{ Name: "linkedInUrl", Type: pipeline.String },

					{ Name: "companyName", Type: pipeline.String, Required:  true},
					{ Name: "companyUrl", Type: pipeline.String },
					{ Name: "companyLinkedInUrl", Type: pipeline.String },
					{ Name: "companyLogoUrl", Type: pipeline.String },
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "createCompanyStep"
			Description: "creates a new company"
			Invoker:     settings.adminInvoker
			PreScript:   """
				{
					'input': {
						'name': get(context.args.input.companyName),
						'url': get(context.args.input.companyUrl),
						'linkedInUrl': get(context.args.input.companyLinkedInUrl),
						'logoUrl': get(context.args.input.companyLogoUrl)
					}
				}"""
			Operation: pipeline.#GraphqlOperation & {
                    Query: """
						mutation createCompany (
							$input: CompanyCreateInput!
						) {
							createCompany(input: $input) {
								id
							}
						}"""
			}
			PostScript: "args.createCompany"
		},
		{
			Name:        "createContactStep"
			Description: "Creates a new contact"
			PreScript:   """
				{
					'input': compact({
						'firstName': get(context.args.input.firstName),
						'lastName': get(context.args.input.lastName),
						'email': get(context.args.input.email),
						'phonePrimary': get(context.args.input.phonePrimary),
						'linkedInUrl': get(context.args.input.linkedInUrl),
						'companyId': get(context.pipeline.createCompanyStep.id)
					})
				}"""
			Operation: pipeline.#GraphqlOperation & {
                    Query: """
					mutation createContact($input: ContactCreateInput!) {
						createContact(input: $input) {
							id
						}
					}"""
			}
			PostScript: "args.createContact"
		},
	]
}
