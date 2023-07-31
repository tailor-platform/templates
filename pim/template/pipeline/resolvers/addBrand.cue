package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

addBrand: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "addBrand"
	description: "creates a new brand"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "createsGroup"
			description: "creates a new group"
			url:         settings.services.gateway
			preScript:   """
			{
				"brandName": context.args.input.brandName
			}"""
			graphqlQuery: """
			mutation createGroup($brandName: String!) {
				createGroup(input: { name: $brandName }) {
					id
				}
			}"""
			postScript: "args.createGroup"
		},
		{
			id: {{generateUUID | quote}}
			name:        "createsBrand"
			description: "creates a new brand"
			url:         settings.services.gateway
			preScript: """
			{
				"brandName": context.args.input.brandName,
				"brandGroupID": context.pipeline.createsGroup.id,
				"brandDescription": context.args.input.brandDescription
			}	
			"""
			graphqlQuery: """
			mutation ($brandName: String!, $brandGroupID: ID!, $brandDescription: String!) {
				createBrand(
					input: {
						brandName: $brandName
						brandGroupID: $brandGroupID
						brandDescription: $brandDescription
					}) 
					{
						id
					}
				}"""
			postScript: "args.createBrand"
		},
	]
}
