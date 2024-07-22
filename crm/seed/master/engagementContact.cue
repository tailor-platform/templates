package master

import (
	"tailor.build/template/seed/utils"
)

#EngagementContact: {
	engagementContact0: {
		id: utils.uuid & {_, #type: "EngagementContact", #value: "1"}
		contactId: utils.uuid & {_, #type: "Contact", #value: "1"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "1"}
	}
	engagementContact1: {
		id: utils.uuid & {_, #type: "EngagementContact", #value: "2"}
		contactId: utils.uuid & {_, #type: "Contact", #value: "2"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "2"}
	}
}

EngagementContact: {
	items: [
		for k, v in #EngagementContact {
			v
		}
	]
}
