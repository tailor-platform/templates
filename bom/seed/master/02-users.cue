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
	user2: {
		id: utils.uuid & {_, #type: "user", #value: "3"}
		email: "test@editor.com"
		roles: [utils.uuid & {_, #type: "roles", #value: "Editor"}]
		name: "Test Editor"
	}
	user3: {
		id: utils.uuid & {_, #type: "user", #value: "4"}
		email: "test@viewer.com"
		roles: [utils.uuid & {_, #type: "roles", #value: "Viewer"}]
		name: "Test Viewer"
	}
}

User: {
	items: [
		for k, v in #Users {
			v
		},
	]
}
