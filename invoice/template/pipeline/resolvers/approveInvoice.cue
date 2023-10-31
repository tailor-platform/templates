package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	"{{ .Values.cue.package }}/charts/directory:directories"
	"encoding/json"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

approveInvoiceInput: {
	name: "approveInvoiceInput"
	fields: [
		{ name: "invoiceID",    type: schema.ID, required: true },
		{ name: "stateID",      type: schema.ID, required: true },
	]
}

approveInvoiceResult: {
	name: "approveInvoiceResult"
	fields: [
		{ name: "success",      type: schema.Boolean },
		{ name: "reviewState",  type: reviewState },
	]
}

reviewState: {
	name: "reviewState"
	fields: [
		{ name: "currentState", type: schema.String },
	]
}


approveInvoice: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	authorization: "true"
	name:          "approveInvoice"
	description:   "approve invoice review to move state"
	inputs: [
		{ name: "input", type:approveInvoiceInput },
	]
	response: { type: approveInvoiceResult }
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "moveState"
			description: "moving a state of invoice review"
			url:         settings.services.gateway
			preScript: """
				{
				  "action": "approve",
				  "stateID": context.args.input.stateID
				}
				"""
			graphqlQuery: """
				mutation ($stateID: ID, $action: String!) {
				  moveState(input: { stateId: $stateID, action: $action }) {
				    success
				    state {
				      currentState
				    }
				  }
				}
				"""
			postScript: "args.moveState"
		},
		{
			id: {{generateUUID | quote}}
			name:        "changeInvoice"
			description: "change permisssion of the invoice record"
			url:         settings.services.gateway
			contextData: json.Marshal({
				managerRoleID: {{ generateApplicationUUID "ManagerRole" | quote }}
				staffRoleID: {{ generateApplicationUUID "StaffRole" | quote }}
				customerRoleID: {{ generateApplicationUUID "CustomerRole" | quote }}
				adminRoleID: directories.roleMap.Admin.id
			})
			test: "!user.roles.exists(e, e == context.data.customerRoleID )"
			preScript: """
				{
				  "invoiceID": context.args.input.invoiceID,
				  "read": [
				    { "id": context.data.managerRoleID, "permit": "allow" },
				    { "id": context.data.staffRoleID, "permit": "allow" },
				    { "id": context.data.customerRoleID, "permit": "allow" },
					{ "id": context.data.adminRoleID, "permit": "allow" }
				    ]
				}
				"""
			graphqlQuery: """
				mutation (
				  $invoiceID: ID!
				  $read: [PermissionItemInput!]
				) {
				  changeInvoice(id: $invoiceID, read: $read)
				}
				"""
			postScript: "context.pipeline.moveState"
		},
	]
}
