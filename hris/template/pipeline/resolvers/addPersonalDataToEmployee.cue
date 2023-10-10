package resolvers

import (
	"tailor.build/hris/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	"encoding/json"
)

addPersonalDataToEmployee: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "addPersonalDataToEmployee"
	description: "creates a new personal data"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "createsPersonalData"
			description: "creates a new personal data"
			url:         settings.services.gateway
			preScript: """
				        {
				          "employeeID": context.args.input.employeeID,
				          "personalEmail": context.args.input.personalEmail,
				          "socialSecurityNumber": context.args.input.socialSecurityNumber,
				          "dateOfBirth": date(context.args.input.dateOfBirth),
				          "hireDate": date(context.args.input.hireDate),
				          "employmentStatus": context.args.input.employmentStatus
				        }"""
			graphqlQuery: """
				        mutation(
				          $employeeID: ID!
				          $personalEmail: String!
				          $socialSecurityNumber: String!
				          $dateOfBirth: Date
				          $hireDate: Date!
				          $employmentStatus: PersonalDataEmploymentStatus!
				          ) {
				        createPersonalData (input: {
				          employeeID: $employeeID
				          personalEmail: $personalEmail
				          socialSecurityNumber: $socialSecurityNumber
				          dateOfBirth: $dateOfBirth
				          hireDate: $hireDate
				          employmentStatus: $employmentStatus
				        }) {
				          id}
				        }"""
			postScript: "args.createPersonalData"
		},
		{
			id: {{generateUUID | quote}}
			name:        "addPerdonalDataToEmployee"
			description: "Adding personal data ID to employee"
			url:         settings.services.gateway
			preScript: """
				      {
				        "personalDataID":args.id,
				        "employeeID":context.args.input.employeeID
				      }"""
			graphqlQuery: """
			mutation ($personalDataID: ID!, $employeeID: ID!) {
				updateEmployee(id: $employeeID, input: { personalDataID: $personalDataID }) {
				  id
				}
			  }"""
			postScript: """
				        {
				          "employeeReadPermission" : [{ "id":context.args.input.employeeID, "permit": "allow"}],
				          "employeeUpdatePermission" : [{ "id":context.args.input.employeeID, "permit": "allow"}]
				        }"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "ChangingPermissionPersonalData"
			description: "Change permission of personal data for this employee"
			url:         settings.services.gateway
			contextData: json.Marshal({settings.permissions})
			preScript: """
				      {
				        "personalDataID":context.pipeline.createsPersonalData.id,
				        "read": context.data.read + args.employeeReadPermission,
				        "update": context.data.update + args.employeeUpdatePermission,
				        "delete": context.data.delete
				      }"""
			graphqlQuery: """
			mutation (
				$personalDataID: ID!
				$read: [PermissionItemInput]
				$update: [PermissionItemInput]
				$delete: [PermissionItemInput]
			  ) {
				changePersonalData(
				  id: $personalDataID
				  read: $read
				  update: $update
				  delete: $delete
				)
			  }"""
			postScript: "args"
		},
	]
}
