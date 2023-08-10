package directories

import (
	"github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1:directoryv1"
)

userTypeMap: {[string]: directoryv1.#UserType} & {
	Permanent: {
		id:  "7b1f3dd6-5e84-5c58-bf29-67973eedc468"
		name: "Permanent"
	}
	Contract: {
		id: "d3794aa6-469c-5433-9660-614dd6358ecc"
		name: "Contract"
	}
	Other: {
		id: "3238eb45-9f78-5b1d-83f5-67feed09145a"
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
		id: "a2971f17-be79-5c39-a09d-618d9cef1cb3"
		name: "Admin"
	}
	Staff: {
		id: "67dccba0-d466-5952-a733-ee0a7287ccfa"
		name: "Staff"
	}
	Manager: {
		id: "c6e204f6-f57b-5d49-9843-15d3487a0c33"
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
		id: "df526ab6-cf59-5df0-b50a-8eacae3b5859"
		name:        "Admin"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: "92e7d4e5-de6b-58c1-bee9-e482aef75565"
		name:        "Staff"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	}
	Manager: directoryv1.#Role & {
		id: "3c46974a-1545-57f6-b3fe-1185e2429878"
		name:        "Manager"
		roleClassId: roleClassMap.Manager.id
		policies: [policyList[1].id]
	}
}

policyList: [...directoryv1.#Policy] & [
		{
		id: "600940b1-606a-50ef-96d2-fae43600abde"
		name:   "admin"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Admin.id
		passwordRule: 4
	},
	{
		id: "b6d76c89-bfe7-5461-8df3-1d7485628800"
		name:   "default"
		permit: "allow"
		actions: ["get", "list"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Staff.id
		passwordRule: 4
	},
	{
		id: "75176147-1ce4-5d13-b24f-49c38c378a94"
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
		id: "f05ec7d3-a947-50bf-89ab-5dfc533659ca"
		name: "internal"
	},
	{
		id: "7c4d4f07-2208-50af-94f3-d34022bd379b"
		name: "external"
	},
]

userList: [...directoryv1.#User] & [
		{
		id: "db6851c9-8366-52da-bebc-d638430d3b57"
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
		id: "8d8ccda0-13f7-53dd-bc27-ee05350ae625"
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
		id: "0e7397a1-8281-5af2-b41b-d1a1625abb42"
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
