package graphqlseed

import (
  "github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
  "uuid"
  "crypto/hmac"
  "{{ .Values.cue.package }}/charts/directory:directories"
)

#seed: uuid.FromInt(2)

manifest.#TailorManifest & {
  version: "v1"
  kind:    manifest.#KindGraphqlSeed
  spec:    manifest.#SpecGraphqlSeed & {
    mutations: [
      {
        query: """
            mutation ($id1:ID,$id2:ID,$id3:ID) {
              createGroup1:createGroup(input: {
                id: $id1,
                name: "Child1"
                code: "1"
                newRepresentativeRole: false
                newBaseRole: false
              }) {
                id
              }
                createGroup2:createGroup(input: {
                id: $id2,
                name: "GrandChild1"
                code: "2"
                newRepresentativeRole: false
                newBaseRole: false
                parentId: $id1
              }) {
                id
              }
              createGroup3:createGroup(input: {
                id: $id3,
                name: "Child2"
                code: "3"
                newRepresentativeRole: false
                newBaseRole: false
              }) {
                id
              }
            } """
        variables: {
          id1: uuid.SHA1(#seed, hmac.Sign("SHA1", "Group", "1"))
          id2: uuid.SHA1(#seed, hmac.Sign("SHA1", "Group", "2"))
          id3: uuid.SHA1(#seed, hmac.Sign("SHA1", "Group", "3"))
        }

      },
      {
        query: """
            mutation ($userID: ID, 
            $gid1: ID!, 
            $gid2: ID!,
            $gid3: ID!, 
            $permanentID: ID!, 
            $contractID: ID!, 
            $adminID: ID!,
            $staffID: ID!,
            ) {
              salesStaffA: addNewEmployee(
                input: {
                  userID: $userID
                  employeeCode: "0000001"
                  displayName: "John Doe"
                  username: "JohnDoe"
                  secret: "2525"
                  firstName: "John"
                  lastName: "Doe"
                  roleInput: [{ id: $staffID }]
                  userTypeID: $permanentID
                  avatar: "https:\/\/picsum.photos/seed/a/200/200"
                  groupInput: [{ id: $gid1 }]
                  mobilePhoneNumber: "12345678"
                  workEmail: "AAAAA@AAAAA.com"
                }
              ) {
                id
              }
              salesStaffB: addNewEmployee(
                input: {
                  employeeCode: "0000002"
                  displayName: "Jane Brake"
                  username: "JaneBrake"
                  secret: "2525"
                  firstName: "Jane"
                  lastName: "Brake"
                  roleInput: [{ id: $staffID }]
                  userTypeID: $permanentID
                  avatar: "https:\/\/picsum.photos/seed/b/200/200"
                  groupInput: [{ id: $gid2 }]
                  mobilePhoneNumber: "12345678"
                  workEmail: "AAAAA@AAAAA.com"
                }
              ) {
                id
              }
              salesStaffC: addNewEmployee(
                input: {
                  employeeCode: "0000003"
                  displayName: "Rogan Hashimoto"
                  username: "RoganHashimoto"
                  secret: "2525"
                  firstName: "Rogan"
                  lastName: "Hashimoto"
                  roleInput: [{ id: $staffID }]
                  userTypeID: $permanentID
                  avatar: "https:\/\/picsum.photos/seed/c/200/200"
                  groupInput: [{ id: $gid3 }]
                  mobilePhoneNumber: "12345678"
                  workEmail: "AAAAA@AAAAA.com"
                }
              ) {
                id
              }
              salesStaffD: addNewEmployee(
                input: {
                  employeeCode: "0000004"
                  displayName: "Grant Hill"
                  username: "GrantHill"
                  secret: "2525"
                  firstName: "Grant"
                  lastName: "Hill"
                  roleInput: [{ id: $staffID }]
                  userTypeID: $contractID
                  avatar: "https:\/\/picsum.photos/seed/d/200/200"
                  groupInput: [{ id: $gid3 }]
                  mobilePhoneNumber: "12345678"
                  workEmail: "AAAAA@AAAAA.com"
                }
              ) {
                id
              }
              salesStaffE: addNewEmployee(
                input: {
                  employeeCode: "0000005"
                  displayName: "Taro Okamoto"
                  username: "OkamotoTaro"
                  secret: "2525"
                  firstName: "Taro"
                  lastName: "Okamoto"
                  roleInput: [{ id: $adminID }]
                  userTypeID: $permanentID
                  avatar: "https:\/\/picsum.photos/seed/e/200/200"
                  groupInput: [{ id: $gid1 }]
                  mobilePhoneNumber: "12345678"
                  workEmail: "AAAAA@AAAAA.com"
                }
              ) {
                id
              }
            } """
        variables: {
          userID:      uuid.SHA1(#seed, hmac.Sign("SHA1", "User", "1"))
          gid1:        uuid.SHA1(#seed, hmac.Sign("SHA1", "Group", "1"))
          gid2:        uuid.SHA1(#seed, hmac.Sign("SHA1", "Group", "2"))
          gid3:        uuid.SHA1(#seed, hmac.Sign("SHA1", "Group", "3"))
          permanentID: directories.userTypeMap.Permanent.id
          contractID:  directories.userTypeMap.Contract.id
          adminID:     directories.roleMap.Admin.id
          staffID:     directories.roleMap.Staff.id
        }
      },
      {
        query: """
            mutation ($userID:ID!,) {
                employmentA:addEmploymentToEmployee(input: {
                  employeeID: $userID
                  employmentType: "FULLTIME"
                  jobTitle: "Product Manager"
                  payPeriod: "YEAR"
                  payRate: 9999
                  effectiveDate: "2022-01-25"
                  payCurrency: "USD"
              }) 
                personalDataA:addPersonalDataToEmployee(input: {
                  employeeID: $userID
                  hireDate: "2022-01-25"
                  dateOfBirth: "1990-01-25"
                  personalEmail: "test@test.com"
                  socialSecurityNumber: "1111"
                  startDate: "2022-02-01"
                  employmentStatus: "ACTIVE"
              }) 
            } """
        variables: {
          userID: uuid.SHA1(#seed, hmac.Sign("SHA1", "User", "1"))
        }
      },
    ]
  }
}
