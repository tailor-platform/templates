package master

import (
	"tailor.build/template/seed/utils"
)

#Team: {
	team0: {
		id: utils.uuid & {_, #type: "Team", #value: "1"}
		name: "Enterprise Sales Team"
	}
	team1: {
		id: utils.uuid & {_, #type: "Team", #value: "2"}
		name: "Saas Sales Team"
	}
}

Team: {
	items: [
		for k, v in #Team {
			v
		}
	]
}
