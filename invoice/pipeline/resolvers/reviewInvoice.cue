package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"
  "encoding/json"
)

reviewInvoice: pipelinev1.#Resolver & {
        id:          {{ generateUUID | quote }}
        name:        "createInvoice"
        description: "create invoice"
        pipeline: [
        {
              id: {{ generateUUID | quote }}
              name: "newState"
              description: "new state for invoice review"
              url: settings.services.gateway
              contextData: json.Marshal({
                id:  {{ generateWorkspaceUUID "ReviewFlow1" | quote }}
              })
              preScript: """
              {
                "resourceId": context.args.input.invoiceID,
                "stateFlowId": context.data.id
              }
              """
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
              }
              """
              postScript: "args.newState"
          },
          {
            id: {{ generateUUID | quote }}
            name: "updateInvoice"
            description: "update invoice with stateID"
            url: settings.services.gateway
            preScript: """
            {
              "stateID": args.id,
              "invoiceID": context.args.input.invoiceID,
            }
            """
            graphqlQuery: """
            mutation ($stateID: ID, $invoiceID: ID!) {
              updateInvoice(id: $invoiceID, input: { stateID: $stateID }) {
                id
                stateID
              }
            }
            """
            postScript: "args.updateInvoice"
        },
        {
          id: {{ generateUUID | quote }}
          name: "changeInvoice"
          description: "change permisssion of the invoice record"
          url: settings.services.gateway
          contextData: json.Marshal({
            managerRoleID: {{ generateWorkspaceUUID "ManagerRole" | quote }}
            staffRoleID: {{ generateWorkspaceUUID "StaffRole" | quote }}
          })
          preScript: """
          {
            "invoiceID": context.args.input.invoiceID,
            "read": [{ "id": context.data.managerRoleID, "permit": "allow" }, { "id": context.data.staffRoleID, "permit": "allow" }],
            "update": [{ "id": context.data.managerRoleID, "permit": "allow" }]
          }
          """
          graphqlQuery: """
          mutation (
            $invoiceID: ID!
            $read: [PermissionItemInput!]
            $update: [PermissionItemInput!]
          ) {
            changeInvoice(id: $invoiceID, read: $read, update: $update)
          }          
          """
          postScript: "context.pipeline.updateInvoice"
        },
        ]
      }
