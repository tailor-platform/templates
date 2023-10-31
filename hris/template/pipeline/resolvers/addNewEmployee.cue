package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

Ids:{
	name: "Ids"
	fields: [
	{ name: "id",          type: schema.ID, required: true },
	]
}

addNewEmployeeInput: {
	name: "addNewEmployeeInput"
	fields: [
		{ name: "userID",            type: schema.ID },
		{ name: "userTypeID",        type: schema.ID, required: true },
		{ name: "groupIds",          type: Ids, array: true },
		{ name: "roleIds",           type: Ids, array: true },
		{ name: "employeeCode",      type: schema.String, required: true },
		{ name: "displayName",       type: schema.String, required: true },
		{ name: "username",          type: schema.String, required: true },
		{ name: "secret",            type: schema.String, required: true },
		{ name: "firstName",         type: schema.String, required: true },
		{ name: "lastName",          type: schema.String, required: true },
		{ name: "avatar",            type: schema.String, required: true },
		{ name: "mobilePhoneNumber", type: schema.String, required: true },
		{ name: "workEmail",         type: schema.String, required: true },
	]
}

addNewEmployee: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "addNewEmployee"
	description: "creates a new employee"
	inputs: [
		{ name: "input", type:addNewEmployeeInput },
	]
	response: { type: schema.ID }
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
				  $roleIds: [RoleInput!]
				  $groupIds: [GroupInput!]
				  $userTypeID: ID
				  $employeeCode: String
				  $userID: ID
				) {
				  createUser(
				    input: {
				      id: $userID
				      username: $username
				      secret: $secret
				      displayName: $displayName
				      roles: $roleIds
				      groups: $groupIds
				      profile: { employeeCode: $employeeCode, userTypeId: $userTypeID }
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
			name:        "createsEmployee"
			description: "creates an employee"
			url:         settings.services.gateway
			preScript: """
			compact({
				"userID":context.pipeline.createsUser.id,
				"displayName":context.pipeline.createsUser.displayName,
				"employeeCode":context.args.input.employeeCode,
				"firstName":context.args.input.firstName,
				"lastName":context.args.input.lastName,
				"avatar":context.args.input.avatar,
				"mobilePhoneNumber":context.args.input.mobilePhoneNumber,
				"workEmail":context.args.input.workEmail
			})"""
			graphqlQuery:
				"""
				       mutation (
				         $userID: ID
				         $displayName: String
				         $employeeCode: String
				         $firstName: String
				         $lastName: String
				         $avatar: String
				         $mobilePhoneNumber: String
				         $workEmail: String
				       ) {
				         createEmployee(
				           id: $userID
				           input: {
				             userID: $userID
				             displayName: $displayName
				             employeeCode: $employeeCode
				             firstName: $firstName
				             lastName: $lastName
				             avatar: $avatar
				             mobilePhoneNumber: $mobilePhoneNumber
				             workEmail: $workEmail
				           }
				         ) {
				           id
				         }
				       }"""
			postScript: "args.createEmployee.id"
		},
	]
}
