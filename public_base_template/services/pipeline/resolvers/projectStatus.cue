package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/services/pipeline:settings"
)

getProjectStatus: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "getProjectStatus"
	Description: "List all projects and its task status along with the assignee info"
	Response: {
		Type: { 
			Name: "GetProjectStatusOutput"
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
					{Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
					{Name: "scheduleDateTime", Type: pipeline.DateTime, Required: true},
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
