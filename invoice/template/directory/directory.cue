package directories

import (
	"github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1:directoryv1"
)

userTypeMap: {[string]: directoryv1.#UserType} & {
	Permanent: {
		id:  {{ generateApplicationUUID "PermanentUserType" | quote }}
		name: "Permanent"
	}
	Contract: {
		id: {{ generateApplicationUUID "ContractUserType" | quote }}
		name: "Contract"
	}
	Other: {
		id: {{ generateApplicationUUID "OtherUserType" | quote }}
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
		id: {{ generateApplicationUUID "AdminRoleClass" | quote }}
		name: "AdminINV"
	}
	Staff: {
		id: {{ generateApplicationUUID "StaffRoleClass" | quote }}
		name: "StaffINV"
	}
	Manager: {
		id: {{ generateApplicationUUID "ManagerRoleClass" | quote }}
		name: "ManagerINV"
	}
	Customer: {
		id: {{ generateApplicationUUID "CustomerRoleClass" | quote }}
		name: "CustomerINV"
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
		id: {{ generateApplicationUUID "AdminRole" | quote }}
		name:        "AdminINV"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: {{ generateApplicationUUID "StaffRole" | quote }}
		name:        "StaffINV"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	}
	Manager: directoryv1.#Role & {
		id: {{ generateApplicationUUID "ManagerRole" | quote }}
		name:        "ManagerINV"
		roleClassId: roleClassMap.Manager.id
		policies: [policyList[1].id]
	}
	Customer: directoryv1.#Role & {
		id: {{ generateApplicationUUID "CustomerRole" | quote }}
		name:        "CustomerINV"
		roleClassId: roleClassMap.Customer.id
		policies: [policyList[2].id]
	}
}

policyList: [...directoryv1.#Policy] & [
		{
		id: {{ generateApplicationUUID "AdminPolicy" | quote }}
		name:   "admin"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Admin.id
		passwordRule: 4
	},
	{
		id: {{ generateApplicationUUID "DefaultPolicy" | quote }}
		name:   "default"
		permit: "allow"
		actions: ["get", "list"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Staff.id
		passwordRule: 4
	},
	{
		id: {{ generateApplicationUUID "CustomerPolicy" | quote }}
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
		id: {{ generateApplicationUUID "InternalGroup" | quote }}
		name: "internal"
	},
	{
		id: {{ generateApplicationUUID "ExternalGroup" | quote }}
		name: "external"
	},
]

userList: [...directoryv1.#User] & [
		{
		id: {{ generateApplicationUUID "AdminUser" | quote }}
		username:    "invoiceadmin"
		displayName: "admin"
		secret:      "invoiceadmin"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateApplicationUUID "StaffUser" | quote }}
		username:    "invoicestaff"
		displayName: "staff"
		secret:      "invoicestaff"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Staff.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateApplicationUUID "ManagerUser" | quote }}
		username:    "invoicemanager"
		displayName: "manager"
		secret:      "invoicemanager"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Manager.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateApplicationUUID "CustomerUser" | quote }}
		username:    "invoicecustomer"
		displayName: "customer"
		secret:      "invoicecustomer"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Other.id
		}
		roles: [roleMap.Customer.id]
		groups: [groupList[1].id]
	},
]
