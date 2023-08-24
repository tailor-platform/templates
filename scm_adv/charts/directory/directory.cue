package directories

import (
	"github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1:directoryv1"
)

userTypeMap: {[string]: directoryv1.#UserType} & {
	Permanent: {
		id:  "7b941ece-aa3a-5c7d-a446-e49558c9b324"
		name: "Permanent"
	}
	Contract: {
		id: "8ad415e8-4468-5aac-932e-4d89f62cc880"
		name: "Contract"
	}
	Other: {
		id: "5adee784-4ff7-5a27-9add-bfd6aad8a1f8"
		name: "Other"
	}
}

userTypeList: [...directoryv1.#UserType] & [
		userTypeMap.Permanent,
		userTypeMap.Contract,
		userTypeMap.Other,
]

roleClassMap: {[string]: directoryv1.#Role} & {
	Admin: {
		id: "dd5f0225-65c2-5536-861e-1f12391a5d26"
		name: "Admin"
	}
	Staff: {
		id: "cc3b8d3d-d70f-574f-b49c-c81c7c9a27be"
		name: "Staff"
	}
	Manager: {
		id: "03abe463-9c1c-5fa7-a67a-9685728179b3"
		name: "Manager"
	}
}

roleClassList: [...directoryv1.#RoleClass] & [
		roleClassMap.Admin,
		roleClassMap.Staff,
		roleClassMap.Manager,
]

roleMap: {[string]: directoryv1.#Role} & {
	Admin: directoryv1.#Role & {
		id: "7b6a0404-7f1a-5856-b786-19070ffcd937"
		name:        "Admin"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: "7a51797f-338a-5247-8864-25f04f7001ff"
		name:        "Staff"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	}
	Manager: directoryv1.#Role & {
		id: "ab29834e-4e41-57aa-b2e3-32e2aea68655"
		name:        "Manager"
		roleClassId: roleClassMap.Manager.id
		policies: [policyList[1].id]
	}
}

policyList: [...directoryv1.#Policy] & [
		{
		id: "06d5697c-b9ed-5fac-be09-c923c12beb03"
		name:   "admin"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Admin.id
		passwordRule: 4
	},
	{
		id: "1d4777b0-5662-5d99-a2eb-af0ef9f34488"
		name:   "default"
		permit: "allow"
		actions: ["get", "list"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Staff.id
		passwordRule: 4
	},
	{
		id: "44239d9a-25a6-52c3-84ca-a58c2fca6219"
		name:   "customer"
		permit: "deny"
		actions: []
		resources: []
		priority:     1
		roleId:       roleMap.Manager.id
		passwordRule: 4
	},

]

roleList: [
	roleMap.Admin,
	roleMap.Staff,
	roleMap.Manager,
]

groupList: [...directoryv1.#Group] & [
		{
		id: "a345560e-37d2-5aa4-9c36-5df564f18905"
		name: "internal"
	},
	{
		id: "abdc758e-7eb5-5fe2-a8ac-fe1299934658"
		name: "external"
	},
]

userList: [...directoryv1.#User] & [
		{
		id: "72e49580-0de2-5bf7-bb7b-950dbe8bfacd"
		username:    "adminadmin"
		displayName: "admin"
		secret:      "adminadmin"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
	{
		id: "46b6c2dd-fbc8-5cad-9eb2-c05ba21cccaa"
		username:    "staffstaff"
		displayName: "staff"
		secret:      "staffstaff"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Staff.id]
		groups: [groupList[0].id]
	},
	{
		id: "032feb53-354f-555b-8c02-1b606d140b6e"
		username:    "managermanager"
		displayName: "manager"
		secret:      "managermanager"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Manager.id]
		groups: [groupList[0].id]
	},
]
