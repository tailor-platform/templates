package master

import (
	"tailor.build/template/seed/utils"
)

#Team: {
	team0: {
		id: utils.uuid & {_, #type: "team", #value: "1"}
		name: "Enterprise Sales Team"
	}
	team1: {
		id: utils.uuid & {_, #type: "team", #value: "2"}
		name: "Saas Sales Team"
	}
}

Team: {
	items: [
		for k, v in #Team {
			v
		},
	]
}
