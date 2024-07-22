package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings:settings"
	role "tailor.build/template/seed/master"
)

approveInvoiceInput: {
	Name: "approveInvoiceInput"
	Fields: [
		{Name: "invoiceID", Type: pipeline.ID, Required: true},
		{Name: "stateID", Type: pipeline.ID, Required: true},
	]
}

approveInvoiceResult: {
	Name: "approveInvoiceResult"
	Fields: [
		{Name: "success", Type: pipeline.Boolean},
		{Name: "reviewState", Type: reviewState},
	]
}

reviewState: {
	Name: "reviewState"
	Fields: [
		{Name: "currentState", Type: pipeline.String},
	]
}

approveInvoice: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "approveInvoice"
	Description:   "approve invoice review to move state"
	Inputs: [
		{Name: "input", Type: approveInvoiceInput},
	]
	Response: {Type: approveInvoiceResult}
	Pipelines: [
		{
			Name:        "moveState"
			Description: "moving a state of invoice review"
			Invoker:     settings.adminInvoker
			PreScript: """
				{
				  "action": "approve",
				  "stateID": context.args.input.stateID
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation ($stateID: ID, $action: String!) {
					  moveState(input: { stateId: $stateID, action: $action }) {
					    success
					    state {
					      currentState
					    }
					  }
					}
					"""
			}
			PostScript: "args.moveState"
		},
		{
			Name:        "changeInvoice"
			Description: "change permissions of the invoice record"
			Test:        "!user.roles.exists(e, e == \(role.#Roles.Customer.id) )"
			PreScript:   """
				{
				  "invoiceID": context.args.input.invoiceID,
				  "read": [
					{ "id": "\(role.#Roles.Manager.id)", "permit": "allow" }, 
					{ "id": "\(role.#Roles.Staff.id)", "permit": "allow" },
					{ "id": "\(role.#Roles.Customer.id)", "permit": "allow"},
					{ "id": "\(role.#Roles.Admin.id)", "permit": "allow" }
				    ]
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation (
					  $invoiceID: ID!
					  $read: [PermissionItemInput!]
					) {
					  changeInvoice(id: $invoiceID, read: $read)
					}
					"""
			}
			PostScript: "context.pipeline.moveState"
		},
	]
}
