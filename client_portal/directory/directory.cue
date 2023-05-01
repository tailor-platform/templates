package directories

import (
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/directory/v1:directoryv1"
)

userTypeMap: {[string]: directoryv1.#UserType } &  {
  Admin: {
    id:   {{ generateUUID | quote }}
    name: "Admin"
  }
  Staff: {
    id:   {{ generateUUID | quote }}
    name: "Staff"
  }
}

userTypeList: [...directoryv1.#UserType] & [
  userTypeMap.Admin,
  userTypeMap.Staff,
]

roleClassMap: {[string]: directoryv1.#Role } & {
	Admin: {
		id:   {{ generateUUID | quote }}
		name: "Admin"
	}
	Staff: {
		id:   {{ generateUUID | quote }}
		name: "Staff"
	}
}

roleClassList: [...directoryv1.#RoleClass] & [
  roleClassMap.Admin,
  roleClassMap.Staff,
]

roleMap: {[string]: directoryv1.#Role } & {
  Admin: directoryv1.#Role & {
    id:   {{ generateUUID | quote }}
    name: "Admin"
		roleClassId: roleClassMap.Admin.id
  }
  Staff: directoryv1.#Role & {
    id:   {{ generateUUID | quote }}
    name: "Staff"
 		roleClassId: roleClassMap.Staff.id
  }
}

policyList: [...directoryv1.#Policy] & [
	{
		id:     {{ generateUUID | quote }}
		name:   "admin"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority: 1
		roleId: roleMap.Admin.id
		passwordRule: 2
	},
	{
		id:     {{ generateUUID | quote }}
		name:   "staff"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority: 4
		roleId: roleMap.Staff.id
		passwordRule: 2
	},
]

roleList: [
  roleMap.Admin,
  roleMap.Staff,
]

groupList: [...directoryv1.#Group] & [
	{
		id:                 {{ generateUUID | quote }}
		name:               "代表"
	},
]

userList: [...directoryv1.#User] & [
		{
		id:          {{ generateUUID | quote }}
		username:    "9000002"
		displayName: "test"
		secret:      "9000002"
		userProfile: directoryv1.#UserProfile & {
			employeeCode: "9000002"
			userTypeId: userTypeMap.Admin.id
		}
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
]
