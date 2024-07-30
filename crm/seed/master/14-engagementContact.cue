package master

import (
	"tailor.build/template/seed/utils"
)

#EngagementContact: {
	EngagementContact1: {
		id: utils.uuid & {_, #type: "engagementcontact", #value: "1"}
		contactId: utils.uuid & {_, #type: "contact", #value: "1"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "1"}
	}
	EngagementContact2: {
		id: utils.uuid & {_, #type: "engagementcontact", #value: "2"}
		contactId: utils.uuid & {_, #type: "contact", #value: "2"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "2"}
	}
}

EngagementContact: {
	items: [
		for k, v in #EngagementContact {
			v
		},
	]
}
