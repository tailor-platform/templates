package directories

import (
	"github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1:directoryv1"
)

userTypeMap: {[string]: directoryv1.#UserType} & {
	Permanent: {
		id:  "dfa75203-65cf-5881-b189-6205100b9271"
		name: "Permanent"
	}
	Contract: {
		id: "6123a271-d703-5128-8c4e-c6ecbb0d90ef"
		name: "Contract"
	}
	Other: {
		id: "cddb2605-553a-5b2e-a602-6720d8b660cc"
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
		id: "358504c2-da4b-5171-964c-a7a4e5506c80"
		name: "Admin"
	}
	Staff: {
		id: "cfee4a8f-6090-5612-9855-904780959a29"
		name: "Staff"
	}
	Manager: {
		id: "5cf91048-427e-5276-9b97-901060d55da8"
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
		id: "81f77dba-108a-5142-b9df-53459760f576"
		name:        "Admin"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: "bd3e55f9-4bd7-5874-b6df-c8b1b9d83913"
		name:        "Staff"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	}
	Manager: directoryv1.#Role & {
		id: "bd895f93-ac65-564e-bde6-c63052ce8aad"
		name:        "Manager"
		roleClassId: roleClassMap.Manager.id
		policies: [policyList[1].id]
	}
}

policyList: [...directoryv1.#Policy] & [
		{
		id: "fe0784d3-bf7b-5781-8c8c-1faabed7d71c"
		name:   "admin"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Admin.id
		passwordRule: 4
	},
	{
		id: "f86461d3-74ad-54db-bd13-b6bb1c345a59"
		name:   "default"
		permit: "allow"
		actions: ["get", "list"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Staff.id
		passwordRule: 4
	},
	{
		id: "c584a5cc-69e5-5f0b-a947-5dd780e795b3"
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
		id: "34e756e2-e24e-5cf0-afc0-8806b80d41f3"
		name: "internal"
	},
	{
		id: "ebc148e6-7867-544e-8caa-c6567fc3f3cb"
		name: "external"
	},
]

userList: [...directoryv1.#User] & [
		{
		id: "088e5721-104f-568c-b390-061c92e79d27"
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
		id: "4e7339cc-0a79-543b-908e-866dfd117b26"
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
		id: "0a22af82-ac61-5936-acec-88ec10299a7c"
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
