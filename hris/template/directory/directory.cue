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
		name: "AdminHRIS"
	}
	Staff: {
		id: {{ generateApplicationUUID "StaffRoleClass" | quote }}
		name: "StaffHRIS"
	}
	Manager: {
		id: {{ generateApplicationUUID "ManagerRoleClass" | quote }}
		name: "ManagerHRIS"
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
		name:        "AdminHRIS"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: {{ generateApplicationUUID "StaffRole" | quote }}
		name:        "StaffHRIS"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	}
	Manager: directoryv1.#Role & {
		id: {{ generateApplicationUUID "ManagerRole" | quote }}
		name:        "ManagerHRIS"
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

userList: [...directoryv1.#User] & [
		{
		id: {{ generateApplicationUUID "AdminUser" | quote }}
		username:    "hris_admin"
		displayName: "admin"
		secret:      "hris_admin"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Admin.id]

	},
	{
		id: {{ generateApplicationUUID "StaffUser" | quote }}
		username:    "hris_staff"
		displayName: "staff"
		secret:      "hris_staff"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Staff.id]

	},
	{
		id: {{ generateApplicationUUID "ManagerUser" | quote }}
		username:    "hris_manager"
		displayName: "manager"
		secret:      "hris_manager"
		userProfile: directoryv1.#UserProfile & {
			userTypeId: userTypeMap.Permanent.id
		}
		roles: [roleMap.Manager.id]

	},
]
