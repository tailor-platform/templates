package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings:settings"
	role "tailor.build/template/seed/master"
)

reviewInvoiceInput: {
	Name: "reviewInvoiceInput"
	Fields: [
		{Name: "invoiceName", Type: pipeline.String, Required: true},
		{Name: "invoiceCode", Type: pipeline.Int},
		{Name: "quote", Type: pipeline.Int, Required: true},
	]
}

reviewInvoiceResult: {
	Name: "reviewInvoiceResult"
	Fields: [
		{Name: "id", Type: pipeline.ID},
		{Name: "stateID", Type: pipeline.ID},
	]
}

reviewInvoice: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "reviewInvoice"
	Description:   "create invoice"
	Inputs: [
		{Name: "input", Type: reviewInvoiceInput},
	]
	Response: {Type: reviewInvoiceResult}
	Pipelines: [
		{
			Name:        "createInvoice"
			Description: "create invoice for a review"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									         mutation (
									           $invoiceCode: Int,
									           $invoiceName: String!,
									           $quote: Int!) {
									           createInvoice(
									             input: {
									               invoiceCode: $invoiceCode
									               invoiceName: $invoiceName
									               quote: $quote
									             }
									           ) {
									             id
									           }
									         }"""
			}
			PostScript: "args.createInvoice"
		},
		{
			Name:        "newState"
			Description: "new state for invoice review"
			Invoker:     settings.adminInvoker
			PreScript:   """
				{
				  "resourceId": args.id,
				  "stateFlowId": "\(role.#StateFlows.ReviewFlow1.id)"
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation ($resourceId: ID!, $stateFlowId: ID!) {
									  newState(
									    input: {
									      resourceId: $resourceId
									      stateFlowId: $stateFlowId
									      name: "invoiceReview"
									    }
									  ) {
									    id
										currentState
									  }
									}"""
			}
			PostScript: "args.newState"
		},
		{
			Name:        "updateInvoice"
			Description: "update invoice with stateID"
			Invoker:     settings.adminInvoker
			PreScript: """
								{
								  "stateID": args.id,
								  "invoiceID": context.pipeline.createInvoice.id
								}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation ($stateID: ID, $invoiceID: ID!) {
									  updateInvoice(id: $invoiceID, input: { stateID: $stateID }) {
									    id
									    stateID
									  }
									}"""
			}
			PostScript: "args.updateInvoice"
		},
		{
			Name:        "changeInvoice"
			Description: "change permissions of the invoice record"
			Invoker:     settings.adminInvoker
			PreScript:   """
				{
				  "invoiceID": context.pipeline.createInvoice.id,
				  "read": [
					{ "id": "\(role.#Roles.Manager.id)", "permit": "allow" }, 
					{ "id": "\(role.#Roles.Staff.id)", "permit": "allow" },
					{ "id": "\(role.#Roles.Admin.id)", "permit": "allow" }
					],
				  "update": [
					{ "id": "\(role.#Roles.Manager.id)", "permit": "allow" },
					{ "id": "\(role.#Roles.Admin.id)", "permit": "allow" }
					]
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation (
									  $invoiceID: ID!
									  $read: [PermissionItemInput!]
									  $update: [PermissionItemInput!]
									) {
									  changeInvoice(id: $invoiceID, read: $read, update: $update)
									}"""
			}
			PostScript: "context.pipeline.updateInvoice"
		},
	]
}
