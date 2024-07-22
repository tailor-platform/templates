package master

import (
	"tailor.build/template/seed/utils"
)

#Users: {
	user1: {
		id: utils.Uuid & {_, #type: "user", #value: "1"}
		email: "test@admin.com"
		roles: [utils.Uuid & {_, #type: "roles", #value: "Admin"}]
		name: "Test Admin"
	}
	user3: {
		id: utils.Uuid & {_, #type: "user", #value: "3"}
		email: "test@manager.com"
		roles: [utils.Uuid & {_, #type: "roles", #value: "Manager"}]
		name: "Test Manager"
	}
	user4: {
		id: utils.Uuid & {_, #type: "user", #value: "4"}
		email: "test@staff.com"
		roles: [utils.Uuid & {_, #type: "roles", #value: "Staff"}]
		name: "Test Staff"
	}
}

User: {
	items:
	[
		for k, v in #Users {
			v
		},
	]
}
