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
		name: "AdminCRM"
	}
	Staff: {
		id: {{ generateApplicationUUID "StaffRoleClass" | quote }}
		name: "StaffCRM"
	}
	Manager: {
		id: {{ generateApplicationUUID "ManagerRoleClass" | quote }}
		name: "ManagerCRM"
	}
}

roleClassList: [...directoryv1.#RoleClass] & [
		roleClassMap.Admin,
		roleClassMap.Staff,
		roleClassMap.Manager,
]

roleMap: {[string]: directoryv1.#Role} & {
	Admin: directoryv1.#Role & {
		id: {{ generateApplicationUUID "AdminRole" | quote }}
		name:        "AdminCRM"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: {{ generateApplicationUUID "StaffRole" | quote }}
		name:        "StaffCRM"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	}
	Manager: directoryv1.#Role & {
		id: {{ generateApplicationUUID "ManagerRole" | quote }}
		name:        "ManagerCRM"
		roleClassId: roleClassMap.Manager.id
		policies: [policyList[1].id]
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
		id: {{ generateApplicationUUID "StaffPolicy" | quote }}
		name:   "default"
		permit: "allow"
		actions: ["get", "list"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Staff.id
		passwordRule: 4
	},
	{
		id: {{ generateApplicationUUID "ManagerPolicy" | quote }}
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
		username:    "crm_admin"
		displayName: "admin"
		secret:      {{ generateApplicationUUID "crm_admin" | quote }}
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateApplicationUUID "StaffUser" | quote }}
		username:    "crm_staff"
		displayName: "staff"
		secret:      {{ generateApplicationUUID "crm_staff" | quote }}
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Staff.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateApplicationUUID "ManagerUser" | quote }}
		username:    "crm_manager"
		displayName: "manager"
		secret:      {{ generateApplicationUUID "crm_manager" | quote }}
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Manager.id]
		groups: [groupList[0].id]
	},
]
