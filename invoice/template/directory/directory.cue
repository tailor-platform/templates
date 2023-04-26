package directories

import (
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/directory/v1:directoryv1"
	"{{ .Values.cue.package }}/charts/common:constant"
)

userTypeMap: {[string]: directoryv1.#UserType} & {
	Admin: {
		id: constant.uuid & {_, #type: "userType", #value: "admin" }
		name: "Admin"
	},
	Staff: {
		id: constant.uuid & {_, #type: "userType", #value: "staff" }
		name: "Staff"
	},
	Manager: {
		id: constant.uuid & {_, #type: "userType", #value: "manager" }
		name: "Manager"
	},
	Customer: {
		id: constant.uuid & {_, #type: "userType", #value: "customer" }
		name: "Customer"
	},
}

userTypeList: [...directoryv1.#UserType] & [
		userTypeMap.Admin,
		userTypeMap.Staff,
		userTypeMap.Manager,
		userTypeMap.Customer,
]

roleClassMap: {[string]: directoryv1.#Role} & {
	Admin: {
		id: constant.uuid & {_, #type: "roleClass", #value: "admin" }
		name: "Admin"
	},
	Staff: {
		id: constant.uuid & {_, #type: "roleClass", #value: "staff" }
		name: "Staff"
	},
	Manager: {
		id: constant.uuid & {_, #type: "roleClass", #value: "manager" }
		name: "Manager"
	},
	Customer: {
		id: constant.uuid & {_, #type: "roleClass", #value: "customer" }
		name: "Customer"
	},
}

roleClassList: [...directoryv1.#RoleClass] & [
		roleClassMap.Admin,
		roleClassMap.Staff,
		roleClassMap.Manager,
		roleClassMap.Customer,
]

roleMap: {[string]: directoryv1.#Role} & {
	Admin: directoryv1.#Role & {
		id: constant.uuid & {_, #type: "role", #value: "admin" }
		name:        "Admin"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	},
	Staff: directoryv1.#Role & {
		id: constant.uuid & {_, #type: "role", #value: "staff" }
		name:        "Staff"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	},
	Manager: directoryv1.#Role & {
		id: constant.uuid & {_, #type: "role", #value: "manager" }
		name:        "Manager"
		roleClassId: roleClassMap.Manager.id
		policies: [policyList[1].id]
	},
	Customer: directoryv1.#Role & {
		id: constant.uuid & {_, #type: "role", #value: "customer" }
		name:        "Customer"
		roleClassId: roleClassMap.Customer.id
		policies: [policyList[2].id]
	},
}

policyList: [...directoryv1.#Policy] & [
		{
		id: constant.uuid & {_, #type: "policy", #value: "admin" }
		name:   "admin"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Admin.id
		passwordRule: 4
	},
	{
		id: constant.uuid & {_, #type: "policy", #value: "default" }
		name:   "default"
		permit: "allow"
		actions: ["get", "list"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Staff.id
		passwordRule: 4
	},
	{
		id: constant.uuid & {_, #type: "policy", #value: "customer" }
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
		id: constant.uuid & {_, #type: "group", #value: "internal" }
		name: "internal"
	},
	{
		id: constant.uuid & {_, #type: "group", #value: "external" }
		name: "external"
	},
]

userList: [...directoryv1.#User] & [
		{
		id: constant.uuid & {_, #type: "user", #value: "admin" }
		username:    "adminadmin"
		displayName: "admin"
		secret:      "adminadmin"
		userProfile: directoryv1.#UserProfile & {
			userTypeId:   userTypeMap.Admin.id
		}
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
	{
		id: constant.uuid & {_, #type: "user", #value: "staff" }
		username:    "staffstaff"
		displayName: "staff"
		secret:      "staffstaff"
		userProfile: directoryv1.#UserProfile & {
			userTypeId:   userTypeMap.Staff.id
		}
		roles: [roleMap.Staff.id]
		groups: [groupList[0].id]
	},
	{
		id: constant.uuid & {_, #type: "user", #value: "manager" }
		username:    "managermanager"
		displayName: "manager"
		secret:      "managermanager"
		userProfile: directoryv1.#UserProfile & {
			userTypeId:   userTypeMap.Manager.id
		}
		roles: [roleMap.Manager.id]
		groups: [groupList[0].id]
	},
	{
		id: constant.uuid & {_, #type: "user", #value: "customer" }
		username:    "customercustomer"
		displayName: "customer"
		secret:      "customercustomer"
		userProfile: directoryv1.#UserProfile & {
			userTypeId:   userTypeMap.Customer.id
		}
		roles: [roleMap.Customer.id]
		groups: [groupList[1].id]
	},
]
