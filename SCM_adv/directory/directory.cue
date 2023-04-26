package directories

import (
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/directory/v1:directoryv1"
	"{{ .Values.cue.package }}/charts/common:constant"
)

userTypeMap: {[string]: directoryv1.#UserType} & {
	Admin: {
		id: constant.uuid & {_, #type: "userType", #value: "admin" }
		name: "Admin"
	}
}

userTypeList: [...directoryv1.#UserType] & [
		userTypeMap.Admin,
]

roleClassMap: {[string]: directoryv1.#Role} & {
	Admin: {
		id: constant.uuid & {_, #type: "roleClass", #value: "admin" }
		name: "Admin"
	}
}

roleClassList: [...directoryv1.#RoleClass] & [
		roleClassMap.Admin,
]

roleMap: {[string]: directoryv1.#Role} & {
	Admin: directoryv1.#Role & {
		id: constant.uuid & {_, #type: "role", #value: "admin" }
		name:        "Admin"
		roleClassId: roleClassMap.Admin.id
		policies: [policyList[0].id]
	}
}

policyList: [...directoryv1.#Policy] & [
		{
		id: constant.uuid & {_, #type: "policy", #value: "default" }
		name:   "default"
		permit: "allow"
		actions: ["*"]
		resources: ["*"]
		priority:     1
		roleId:       roleMap.Admin.id
		passwordRule: 4
	},

]

roleList: [
	roleMap.Admin,
]

groupList: [...directoryv1.#Group] & [
		{
		id: constant.uuid & {_, #type: "group", #value: "root" }
		name: "root"
	},
]

userList: [...directoryv1.#User] & [
		{
		id: constant.uuid & {_, #type: "user", #value: "admin" }
		username:    "SCM9000002"
		displayName: "test"
		secret:      "SCM9000002"
		userProfile: directoryv1.#UserProfile & {
			employeeCode: "9000002"
			userTypeId:   userTypeMap.Admin.id
		}
		roles: [roleMap.Admin.id]
		groups: [groupList[0].id]
	},
]
