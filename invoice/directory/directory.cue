package directories

import (
	"github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1:directoryv1"
)

userTypeMap: {[string]: directoryv1.#UserType} & {
	Permanent: {
		id:  {{ generateWorkspaceUUID "PermanentUserType" | quote }}
		name: "Permanent"
	}
	Contract: {
		id: {{ generateWorkspaceUUID "ContractUserType" | quote }}
		name: "Contract"
	}
	Other: {
		id: {{ generateWorkspaceUUID "OtherUserType" | quote }}
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
		id: {{ generateWorkspaceUUID "AdminRoleClass" | quote }}
		name: "Admin"
	}
	Staff: {
		id: {{ generateWorkspaceUUID "StaffRoleClass" | quote }}
		name: "Staff"
	}
	Manager: {
		id: {{ generateWorkspaceUUID "ManagerRoleClass" | quote }}
		name: "Manager"
	}
	Customer: {
		id: {{ generateWorkspaceUUID "CustomerRoleClass" | quote }}
		name: "Customer"
	}
}

roleClassList: [...directoryv1.#RoleClass] & [
		roleClassMap.Admin,
		roleClassMap.Staff,
		roleClassMap.Manager,
		roleClassMap.Customer,
]

roleMap: {[string]: directoryv1.#Role} & {
	Admin: directoryv1.#Role & {
		id: {{ generateWorkspaceUUID "AdminRole" | quote }}
		name:        "Admin"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: {{ generateWorkspaceUUID "StaffRole" | quote }}
		name:        "Staff"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	}
	Manager: directoryv1.#Role & {
		id: {{ generateWorkspaceUUID "ManagerRole" | quote }}
		name:        "Manager"
		roleClassId: roleClassMap.Manager.id
		policies: [policyList[1].id]
	}
	Customer: directoryv1.#Role & {
		id: {{ generateWorkspaceUUID "CustomerRole" | quote }}
		name:        "Customer"
		roleClassId: roleClassMap.Customer.id
		policies: [policyList[2].id]
	}
}

policyList: [...directoryv1.#Policy] & [
		{
		id: {{ generateWorkspaceUUID "AdminPolicy" | quote }}
		name:   "admin"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Admin.id
		passwordRule: 4
	},
	{
		id: {{ generateWorkspaceUUID "DefaultPolicy" | quote }}
		name:   "default"
		permit: "allow"
		actions: ["get", "list"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Staff.id
		passwordRule: 4
	},
	{
		id: {{ generateWorkspaceUUID "CustomerPolicy" | quote }}
		name:   "customer"
		permit: "deny"
		actions: []
		resources: []
		priority:     1
		roleId:       roleMap.Customer.id
		passwordRule: 4
	},
]

roleList: [
	roleMap.Admin,
	roleMap.Staff,
	roleMap.Manager,
	roleMap.Customer,
]

groupList: [...directoryv1.#Group] & [
		{
		id: {{ generateWorkspaceUUID "InternalGroup" | quote }}
		name: "internal"
	},
	{
		id: {{ generateWorkspaceUUID "ExternalGroup" | quote }}
		name: "external"
	},
]

userList: [...directoryv1.#User] & [
		{
		id: {{ generateWorkspaceUUID "AdminUser" | quote }}
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
		id: {{ generateWorkspaceUUID "StaffUser" | quote }}
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
		id: {{ generateWorkspaceUUID "ManagerUser" | quote }}
		username:    "managermanager"
		displayName: "manager"
		secret:      "managermanager"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Manager.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateWorkspaceUUID "CustomerUser" | quote }}
		username:    "customercustomer"
		displayName: "customer"
		secret:      "customercustomer"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Other.id
		}
		roles: [roleMap.Customer.id]
		groups: [groupList[1].id]
	},
]
