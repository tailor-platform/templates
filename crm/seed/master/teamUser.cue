package master

import (
	"tailor.build/template/seed/utils"
)

#TeamUser: {
	teamUser0: {
		id: utils.uuid & {_, #type: "TeamUser", #value: "1"}
		teamId: utils.uuid & {_, #type: "Team", #value: "1"}
		userId: utils.uuid & {_, #type: "User", #value: "1"}
		isSecondaryUser: false
	}
	teamUser1: {
		id: utils.uuid & {_, #type: "TeamUser", #value: "2"}
		teamId: utils.uuid & {_, #type: "Team", #value: "2"}
		userId: utils.uuid & {_, #type: "User", #value: "2"}
		isSecondaryUser: true
	}
}

TeamUser: {
	items: [
		for k, v in #TeamUser {
			v
		}
	]
}
