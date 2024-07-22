package master

import (
	"tailor.build/template/seed/utils"
)

#Roles: {
	Admin: {
		id: utils.Uuid & {_, #type: "roles", #value: "Admin"}
		name: "Admin"
	}
	Manager: {
		id: utils.Uuid & {_, #type: "roles", #value: "Manager"}
		name: "Manager"
	}
	Staff: {
		id: utils.Uuid & {_, #type: "roles", #value: "Staff"}
		name: "Staff"
	}
}

Role: {
	items:
	[
		for k, v in #Roles {
			v
		},
	]
}
