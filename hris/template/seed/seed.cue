package graphqlseed

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"{{ .Values.cue.package }}/charts/directory:directories"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGraphqlSeed
	spec:    manifest.#SpecGraphqlSeed & {
		mutations: [
			{
				query: """
				mutation ($id1: ID, $id2: ID, $id3: ID) {
					createGroup1: createGroup(
					  input: {
						id: $id1
						name: "Child1"
						code: "1"
						newRepresentativeRole: false
						newBaseRole: false
					  }
					) {
					  id
					}
					createGroup2: createGroup(
					  input: {
						id: $id2
						name: "GrandChild1"
						code: "2"
						newRepresentativeRole: false
						newBaseRole: false
						parentId: $id1
					  }
					) {
					  id
					}
					createGroup3: createGroup(
					  input: {
						id: $id3
						name: "Child2"
						code: "3"
						newRepresentativeRole: false
						newBaseRole: false
					  }
					) {
					  id
					}
				  }"""
				variables: {
					id1: {{ generateApplicationUUID "Group1" | quote }}
					id2: {{ generateApplicationUUID "Group2" | quote }}
					id3: {{ generateApplicationUUID "Group3" | quote }}
				}
			},
			{
				query: """
				mutation (
					$userID1: ID
					$userID2: ID
					$gid1: ID!
					$gid2: ID!
					$gid3: ID!
					$permanentID: ID!
					$contractID: ID!
					$adminID: ID!
					$staffID: ID!
				  ) {
					salesStaffA: addNewEmployee(
					  input: {
						userID: $userID1
						employeeCode: "0000001"
						displayName: "John Doe"
						username: "JohnDoe"
						secret: "2525"
						firstName: "John"
						lastName: "Doe"
						roleIds: [{ id: $adminID }]
						userTypeID: $permanentID
						avatar: "https:\/\/picsum.photos/seed/a/200/200"
						groupIds: [{ id: $gid1 }]
						mobilePhoneNumber: "12345678"
						workEmail: "AAAAA@AAAAA.com"
					  }
					) 
					salesStaffB: addNewEmployee(
					  input: {
						userID: $userID2
						employeeCode: "0000002"
						displayName: "Jane Brake"
						username: "JaneBrake"
						secret: "2525"
						firstName: "Jane"
						lastName: "Brake"
						roleIds: [{ id: $staffID }]
						userTypeID: $permanentID
						avatar: "https:\/\/picsum.photos/seed/b/200/200"
						groupIds: [{ id: $gid2 }]
						mobilePhoneNumber: "12345678"
						workEmail: "AAAAA@AAAAA.com"
					  }
					) 
					salesStaffC: addNewEmployee(
					  input: {
						employeeCode: "0000003"
						displayName: "Rogan Hashimoto"
						username: "RoganHashimoto"
						secret: "2525"
						firstName: "Rogan"
						lastName: "Hashimoto"
						roleIds: [{ id: $staffID }]
						userTypeID: $permanentID
						avatar: "https:\/\/picsum.photos/seed/c/200/200"
						groupIds: [{ id: $gid3 }]
						mobilePhoneNumber: "12345678"
						workEmail: "AAAAA@AAAAA.com"
					  }
					) 
					salesStaffD: addNewEmployee(
					  input: {
						employeeCode: "0000004"
						displayName: "Grant Hill"
						username: "GrantHill"
						secret: "2525"
						firstName: "Grant"
						lastName: "Hill"
						roleIds: [{ id: $staffID }]
						userTypeID: $contractID
						avatar: "https:\/\/picsum.photos/seed/d/200/200"
						groupIds: [{ id: $gid3 }]
						mobilePhoneNumber: "12345678"
						workEmail: "AAAAA@AAAAA.com"
					  }
					)
					salesStaffE: addNewEmployee(
					  input: {
						employeeCode: "0000005"
						displayName: "Taro Okamoto"
						username: "OkamotoTaro"
						secret: "2525"
						firstName: "Taro"
						lastName: "Okamoto"
						roleIds: [{ id: $staffID }]
						userTypeID: $permanentID
						avatar: "https:\/\/picsum.photos/seed/e/200/200"
						groupIds: [{ id: $gid1 }]
						mobilePhoneNumber: "12345678"
						workEmail: "AAAAA@AAAAA.com"
					  }
					)
				  }"""
				variables: {
					userID1:      {{ generateApplicationUUID "User1" | quote }}
					userID2:      {{ generateApplicationUUID "User2" | quote }}
					gid1:        {{ generateApplicationUUID "Group1" | quote }}
					gid2:        {{ generateApplicationUUID "Group2" | quote }}
					gid3:        {{ generateApplicationUUID "Group3" | quote }}
					permanentID: directories.userTypeMap.Permanent.id
					contractID:  directories.userTypeMap.Contract.id
					adminID:     directories.roleMap.Admin.id
					staffID:     directories.roleMap.Staff.id
				}
			},
			{
				query: """
				mutation ($userID1: ID!, $userID2: ID!) {
					employmentA: addEmploymentToEmployee(
					  input: {
						employeeID: $userID1
						employmentType: "FULLTIME"
						jobTitle: "System Administrator"
						payPeriod: "YEAR"
						payRate: 9999
						effectiveDate: "2022-01-25"
						payCurrency: "USD"
					  }
					)
					personalDataA: addPersonalDataToEmployee(
					  input: {
						employeeID: $userID1
						hireDate: "2022-01-25"
						dateOfBirth: "1990-01-25"
						personalEmail: "test@test.com"
						socialSecurityNumber: "123456789"
						employmentStatus: "ACTIVE"
					  }
					)

					employmentB: addEmploymentToEmployee(
					  input: {
						employeeID: $userID2
						employmentType: "FULLTIME"
						jobTitle: "Product Manager"
						payPeriod: "YEAR"
						payRate: 9999
						effectiveDate: "2022-01-25"
						payCurrency: "USD"
					  }
					)
					personalDataB: addPersonalDataToEmployee(
					  input: {
						employeeID: $userID2
						hireDate: "2022-01-25"
						dateOfBirth: "1995-01-25"
						personalEmail: "test@test.com"
						socialSecurityNumber: "987654321"
						employmentStatus: "ACTIVE"
					  }
					)
				  }"""
				variables: {
					  userID1: {{ generateApplicationUUID "User1" | quote }}
					  userID2: {{ generateApplicationUUID "User2" | quote }}
				}
			},
		]
	}
}
