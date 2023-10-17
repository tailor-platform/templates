package directories

import (
	"github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1:directoryv1"
)

roleClassMap: {[string]: directoryv1.#Role} & {
	Admin: {
		id: {{ generateApplicationUUID "AdminRoleClass" | quote }}
		name: "AdminSTFW"
	}
	Staff: {
		id: {{ generateApplicationUUID "StaffRoleClass" | quote }}
		name: "StaffSTFW"
	}
	Manager: {
		id: {{ generateApplicationUUID "ManagerRoleClass" | quote }}
		name: "ManagerSTFW"
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
		name:        "AdminSTFW"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: {{ generateApplicationUUID "StaffRole" | quote }}
		name:        "StaffSTFW"
		roleClassId: roleClassMap.Staff.id
		policies: [policyList[1].id]
	}
	Manager: directoryv1.#Role & {
		id: {{ generateApplicationUUID "ManagerRole" | quote }}
		name:        "ManagerSTFW"
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
		username:    "todo_app_stateflow_admin"
		displayName: "admin"
		secret:      "todo_app_stateflow_admin"
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateApplicationUUID "StaffUser" | quote }}
		username:    "todo_app_stateflow_staff"
		displayName: "staff"
		secret:      "todo_app_stateflow_staff"
		roles: [roleMap.Staff.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateApplicationUUID "ManagerUser" | quote }}
		username:    "todo_app_stateflow_manager"
		displayName: "manager"
		secret:      "todo_app_stateflow_manager"
		roles: [roleMap.Manager.id]
		groups: [groupList[0].id]
	},
]
