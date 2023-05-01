package resolvers

import (
  "{{ .Values.cue.package }}/charts/pipeline:settings"
  "github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"
)

addNewEmployee: pipelinev1.#Resolver & {
  id:          {{ generateUUID | quote }}
  name:        "addNewEmployee"
  description: "creates a new employee"
  pipeline: [
    {
      id:          {{ generateUUID | quote }}
      name:        "createsUser"
      description: "creates a new user"
      url:         settings.services.directory
      preScript:   "context.args.input"
      graphqlQuery: """
        mutation (
          $displayName: String!
          $username: String!
          $secret: String!
          $roleInput: [RoleInput!]
          $groupInput: [GroupInput!]
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
              roles: $roleInput
              groups: $groupInput
              profile: { employeeCode: $employeeCode, userTypeId: $userTypeID }
            }
          ) {
            id
            displayName
          }
        }        """
      postScript: "args.createUser"
    },
    {
      id:          {{ generateUUID | quote }}
      name:        "createsEmployee"
      description: "creates an employee"
      url:         settings.services.gateway
      preScript: """
       {
            "userID":context.pipeline.createsUser.id,
            "displayName":context.pipeline.createsUser.displayName,
            "employeeCode":context.args.input.employeeCode,
            "firstName":context.args.input.firstName,
            "lastName":context.args.input.lastName,
            "avatar":context.args.input.avatar,
            "mobilePhoneNumber":context.args.input.mobilePhoneNumber,
            "workEmail":context.args.input.workEmail
      }  """
      graphqlQuery: """
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
        } """
      postScript: "args.createEmployee"
    },
  ]
}

