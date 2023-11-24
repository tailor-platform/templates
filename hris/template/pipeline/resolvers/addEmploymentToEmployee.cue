package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	"encoding/json"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

addEmploymentToEmployeeInput: {
	name: "addEmploymentToEmployeeInput"
	fields: [
		{ name: "employeeID",      type: schema.ID, required: true},
		{ name: "jobTitle",        type: schema.String, required: true },
		{ name: "payPeriod",       type: schema.String },
		{ name: "payCurrency",     type: schema.String, required: true },
		{ name: "employmentType",  type: schema.String },
		{ name: "payRate",         type: schema.Int, required: true },
		{ name: "effectiveDate",   type: schema.Date},
	]
}

addEmploymentToEmployee: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "addEmploymentToEmployee"
	description: "creates a new employment data"
	inputs: [
		{ name: "input", type:addEmploymentToEmployeeInput },
	]
	response: { type: schema.Boolean }

	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "createEmployment"
			description: "creates a new employment data"
			url:         settings.services.gateway
			preScript: """
			compact({
				"employeeID": context.args.input.employeeID,
				"jobTitle": context.args.input.jobTitle,
				"payRate": context.args.input.payRate,
				"payPeriod": context.args.input.payPeriod,
				"payCurrency": context.args.input.payCurrency,
				"effectiveDate": date(context.args.input.effectiveDate),
				"employmentType": context.args.input.employmentType
			})"""
			graphqlQuery: """
			mutation(
			  $employeeID: ID!
			  $jobTitle: String!
			  $payRate: Int
			  $payPeriod: EmploymentPayPeriod
			  $payCurrency: String
			  $effectiveDate: Date
			  $employmentType: EmploymentEmploymentType
			  ) {
			createEmployment (input: {
			  employeeID: $employeeID
			  jobTitle: $jobTitle
			  payRate: $payRate
			  payPeriod: $payPeriod
			  payCurrency: $payCurrency
			  effectiveDate: $effectiveDate
			  employmentType: $employmentType
			}) {
			  id }
			}"""
			postScript: "args.createEmployment"
		},
		{
			id: {{generateUUID | quote}}
			name:        "addPerdonalDataToEmployee"
			description: "Adding personal data ID to employee"
			url:         settings.services.gateway
			preScript: """
			{
				"employmentID":args.id,
				"employeeID":context.args.input.employeeID
			}"""
			graphqlQuery: """
			mutation ($employmentID: ID!, $employeeID: ID!) {
				updateEmployee(id: $employeeID, input: { employmentID: $employmentID }) {
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
			name:        "ChangingPermissionEmployment"
			description: "Change permission of employment data for this employee"
			url:         settings.services.gateway
			contextData: json.Marshal({settings.permissions})
			preScript: """
			{
				"employmentID":context.pipeline.createEmployment.id,
				"read": context.data.read + args.employeeReadPermission,
				"update": context.data.update + args.employeeUpdatePermission,
				"delete": context.data.delete
			}"""
			graphqlQuery: """
			mutation (
				$employmentID: ID!
				$read: [PermissionItemInput]
				$update: [PermissionItemInput]
				$delete: [PermissionItemInput]
			  ) {
				changeEmployment(
				  id: $employmentID
				  read: $read
				  update: $update
				  delete: $delete
				)
			  }"""
			postScript: "args.changeEmployment"
		},
	]
}
