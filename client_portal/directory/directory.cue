package directories

import (
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/directory/v1:directoryv1"
)

roleClassMap: {[string]: directoryv1.#Role} & {
	Admin: {
		id: {{ generateWorkspaceUUID "AdminRoleClass" | quote }}
		name: "Admin"
	}
	Staff: {
		id: {{ generateWorkspaceUUID "StaffRoleClass" | quote }}
		name: "Staff"
	}
}

roleClassList: [...directoryv1.#RoleClass] & [
		roleClassMap.Admin,
		roleClassMap.Staff,
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
		id: {{ generateWorkspaceUUID "StaffPolicy" | quote }}
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
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
	{
		id: {{ generateWorkspaceUUID "StaffUser" | quote }}
		username:    "staffstaff"
		displayName: "staff"
		secret:      "staffstaff"
		roles: [roleMap.Staff.id]
		groups: [groupList[0].id]
	},
]
