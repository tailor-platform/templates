package master

import (
	"tailor.build/template/seed/utils"
)

#Roles: {
	Admin: {
		id: utils.uuid & {_, #type: "roles", #value: "Admin"}
		name: "Admin"
	}
	Manager: {
		id: utils.uuid & {_, #type: "roles", #value: "Manager"}
		name: "Manager"
	}
	Staff: {
		id: utils.uuid & {_, #type: "roles", #value: "Staff"}
		name: "Staff"
	}
	Customer: {
		id: utils.uuid & {_, #type: "roles", #value: "Customer"}
		name: "Customer"
	}
}

Role: {
	items: [
		for k, v in #Roles {
			v
		},
	]
}
