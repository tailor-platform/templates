package directories

import (
	"github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1:directoryv1"
)

roleClassMap: {[string]: directoryv1.#Role} & {
	Admin: {
		id: {{ generateApplicationUUID "AdminRoleClass" | quote }}
		name: "Admin"
	}
	Staff: {
		id: {{ generateApplicationUUID "StaffRoleClass" | quote }}
		name: "Staff"
	}
}

roleClassList: [...directoryv1.#RoleClass] & [
		roleClassMap.Admin,
		roleClassMap.Staff,
]

roleMap: {[string]: directoryv1.#Role} & {
	Admin: directoryv1.#Role & {
		id: {{ generateApplicationUUID "AdminRole" | quote }}
		name:        "AdminCP"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
	Staff: directoryv1.#Role & {
		id: {{ generateApplicationUUID "StaffRole" | quote }}
		name:        "StaffCP"
		roleClassId: roleClassMap.Staff.id
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
]

roleList: [
	roleMap.Admin,
	roleMap.Staff,
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
		username:    "client_portaladmin"
		displayName: "admin"
		secret:      "client_portaladmin"
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateApplicationUUID "StaffUser" | quote }}
		username:    "client_portalstaff"
		displayName: "staff"
		secret:      "client_portalstaff"
		roles: [roleMap.Staff.id]
		groups: [groupList[0].id]
	},
]
