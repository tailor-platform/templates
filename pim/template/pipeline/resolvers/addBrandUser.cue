package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

addBrandUser: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "addBrandUser"
	description: "creates a new brand user"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "createsUser"
			description: "creates a new user"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
				mutation (
				  $displayName: String!
				  $username: String!
				  $secret: String!
				  $roleInput: [RoleInput!]
				  $groupInput: [GroupInput!]
				  $userID: ID
				) {
				  createUser(
				    input: {
				      id: $userID
				      username: $username
				      secret: $secret
				      displayName: $displayName
				      roles: $roleInput
				      groups: $groupInput
				    }
				  ) {
				    id
				    displayName
				  }
				}"""
			postScript: "args.createUser"
		},
		{
			id: {{generateUUID | quote}}
			name:        "createsBrandUser"
			description: "creates a brandUser"
			url:         settings.services.gateway
			preScript: """
				     {
						"userID":context.pipeline.createsUser.id,
						"brandID":context.args.input.brandID,
						"brandGroupID":context.args.input.brandID,
						"brandName":context.args.input.brandName
				    }"""
			graphqlQuery: """
			mutation (
				$userID: ID!
				$brandID: ID!
				$brandName: String!
				$brandGroupID: ID!
				) {
				  createBrandUser(
					id: $userID
					input: {
						userID: $userID
						brandID: $brandID
						brandName: $brandName
						brandGroupID: $brandGroupID
						}
					) {
						id
					}
			}"""
			postScript: "args.createBrandUser"
		},
	]
}
