package master

import (
	"tailor.build/template/seed/utils"
)

#Users: {
	user1: {
		id: utils.uuid & {_, #type: "user", #value: "1"}
		email: "test@admin.com"
		roles: [utils.uuid & {_, #type: "roles", #value: "Admin"}]
		name: "Test Admin"
	}
	user3: {
		id: utils.uuid & {_, #type: "user", #value: "3"}
		email: "test@manager.com"
		roles: [utils.uuid & {_, #type: "roles", #value: "Manager"}]
		name: "Test Manager"
	}
	user4: {
		id: utils.uuid & {_, #type: "user", #value: "4"}
		email: "test@staff.com"
		roles: [utils.uuid & {_, #type: "roles", #value: "Staff"}]
		name: "Test Staff"
	}
	user5: {
		id: utils.uuid & {_, #type: "user", #value: "5"}
		email: "test@customer.com"
		roles: [utils.uuid & {_, #type: "roles", #value: "Customer"}]
		name: "Test Customer"
	}
}

User: {
	items: [
		for k, v in #Users {
			v
		},
	]
}
