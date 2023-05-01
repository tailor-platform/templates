package pipelines

import (
  "{{ .Values.cue.package }}/charts/directory:directories"
  "{{ .Values.cue.package }}/charts/pipeline/resolvers"
  "github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
  namespace:   {{ .Values.pipeline.namespace | quote }}
  invoker:     directories.roleMap.Admin.id
  description: "HRIS pipeline resolver"
  sdl: """
      input CreateEmployeeInput {
        employeeCode: String!
        displayName: String!
        username: String!
        secret: String!
        roleInput: [idInput]
        firstName: String!
        lastName: String!
        userTypeID: ID!
        avatar: String!
        groupInput: [idInput]
        userID: ID
        mobilePhoneNumber: String!
        workEmail: String!
      }
      input idInput {
        id: ID!
      }
      type CreateEmployeeResult {
        id: ID
      }
      scalar Date
      input addPersonalDataToEmployeeInput {
        employeeID: ID!
        personalEmail: String!
        socialSecurityNumber: String!
        dateOfBirth: Date
        hireDate: Date!
        startDate: Date!
        employmentStatus: String
      }
      input addEmploymentToEmployeeInput {
        employeeID: ID!
        jobTitle: String!
        payRate: Int!
        payPeriod: String
        payCurrency: String!
        effectiveDate: Date
        employmentType: String
      }
      type Mutation {
        addNewEmployee(input: CreateEmployeeInput): CreateEmployeeResult
        addPersonalDataToEmployee(input: addPersonalDataToEmployeeInput): Boolean
        addEmploymentToEmployee(input: addEmploymentToEmployeeInput): Boolean
      }  """
  resolverMap: {
    "addEmploymentToEmployee": resolvers.addEmploymentToEmployee,
    "addNewEmployee": resolvers.addNewEmployee,
    "addPersonalDataToEmployee": resolvers.addPersonalDataToEmployee,
  }
}
