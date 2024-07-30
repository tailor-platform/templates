package master

import (
	"tailor.build/template/seed/utils"
)

#Engagement: {
	engagement1: {
		id: utils.uuid & {_, #type: "engagement", #value: "1"}
		active:       true
		activityType: "Initial Outreach"
		userId: utils.uuid & {_, #type: "user", #value: "1"}
		type: "email"
	}
	engagement2: {
		id: utils.uuid & {_, #type: "engagement", #value: "2"}
		active:       true
		activityType: "Prospect Sent"
		userId: utils.uuid & {_, #type: "user", #value: "2"}
		type: "email"
	}
	engagement3: {
		id: utils.uuid & {_, #type: "engagement", #value: "3"}
		active:       true
		activityType: "Estimation sent"
		userId: utils.uuid & {_, #type: "user", #value: "2"}
		type: "email"
	}
}

Engagement: {
	items: [
		for k, v in #Engagement {
			v
		},
	]
}
