package resolvers

import (
	"tailor.build/invoice/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	"tailor.build/invoice/charts/directory:directories"
	"encoding/json"
)

reviewInvoice: pipelinev1.#Resolver & {
	authorization: "true"
	id:          {{ generateUUID | quote }}
	authorization: "true"
	name:          "createInvoice"
	description:   "create invoice"
	pipeline: [
		{
			id: {{ generateUUID | quote }}
			name:        "createInvoice"
			description: "create invoice for a review"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
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
			postScript: "args.createInvoice"
		},
		{
			id: {{ generateUUID | quote }}
			name:        "newState"
			description: "new state for invoice review"
			url:         settings.services.gateway
			contextData: json.Marshal({
				id:  {{ generateApplicationUUID "ReviewFlow1" | quote }}
			})
			preScript: """
				{
				  "resourceId": args.id,
				  "stateFlowId": context.data.id
				}"""
			graphqlQuery: """
				mutation ($resourceId: ID!, $stateFlowId: ID!) {
				  newState(
				    input: {
				      resourceId: $resourceId
				      stateFlowId: $stateFlowId
				      name: "invoiceReview"
				    }
				  ) {
				    id
				  }
				}"""
			postScript: "args.newState"
		},
		{
			id: {{ generateUUID | quote }}
			name:        "updateInvoice"
			description: "update invoice with stateID"
			url:         settings.services.gateway
			preScript: """
				{
				  "stateID": args.id,
				  "invoiceID": context.pipeline.createInvoice.id
				}"""
			graphqlQuery: """
				mutation ($stateID: ID, $invoiceID: ID!) {
				  updateInvoice(id: $invoiceID, input: { stateID: $stateID }) {
				    id
				    stateID
				  }
				}"""
			postScript: "args.updateInvoice"
		},
		{
			id: {{ generateUUID | quote }}
			name:        "changeInvoice"
			description: "change permisssion of the invoice record"
			url:         settings.services.gateway
			contextData: json.Marshal({
				managerRoleID: {{ generateApplicationUUID "ManagerRole" | quote }}
				staffRoleID: {{ generateApplicationUUID "StaffRole" | quote }}
				adminRoleID: directories.roleMap.Admin.id
			})
			preScript: """
				{
				  "invoiceID": context.pipeline.createInvoice.id,
				  "read": [
					{ "id": context.data.managerRoleID, "permit": "allow" }, 
					{ "id": context.data.staffRoleID, "permit": "allow" },
					{ "id": context.data.adminRoleID, "permit": "allow" }
					],
				  "update": [{ "id": context.data.managerRoleID, "permit": "allow" }]
				}"""
			graphqlQuery: """
				mutation (
				  $invoiceID: ID!
				  $read: [PermissionItemInput!]
				  $update: [PermissionItemInput!]
				) {
				  changeInvoice(id: $invoiceID, read: $read, update: $update)
				}"""
			postScript: "context.pipeline.updateInvoice"
		},
	]
}
