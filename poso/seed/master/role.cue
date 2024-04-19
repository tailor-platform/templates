package master

import (
	"tailor.build/template/seed/utils"
)

#Roles: {
	Admin: {
		id: utils.uuid & {_, #type: "roles", #value: "Admin"}
		name: "Admin"
	}
	Editor: {
		id: utils.uuid & {_, #type: "roles", #value: "Editor"}
		name: "Editor"
	}
	Viewer: {
		id: utils.uuid & {_, #type: "roles", #value: "Viewer"}
		name: "Viewer"
	}
}

Role: {
	items: [
		for k, v in #Roles {
			v
		},
	]
}
