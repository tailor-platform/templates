package master

import (
	"tailor.build/template/seed/utils"
)

#EngagementDeal: {
	engagementDeal1: {
		id: utils.uuid & {_, #type: "EngagementDeal", #value: "1"}
		dealId: utils.uuid & {_, #type: "Deal", #value: "1"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "1"}
	}
	engagementDeal2: {
		id: utils.uuid & {_, #type: "EngagementDeal", #value: "2"}
		dealId: utils.uuid & {_, #type: "Deal", #value: "2"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "2"}
	}
	engagementDeal3: {
		id: utils.uuid & {_, #type: "EngagementDeal", #value: "3"}
		dealId: utils.uuid & {_, #type: "Deal", #value: "3"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "3"}
	}
}

EngagementDeal: {
	items: [
		for k, v in #EngagementDeal {
			v
		}
	]
}
