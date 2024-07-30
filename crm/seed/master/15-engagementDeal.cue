package master

import (
	"tailor.build/template/seed/utils"
)

#EngagementDeal: {
	engagementDeal1: {
		id: utils.uuid & {_, #type: "engagementdeal", #value: "1"}
		dealId: utils.uuid & {_, #type: "deal", #value: "1"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "1"}
	}
	engagementDeal2: {
		id: utils.uuid & {_, #type: "engagementdeal", #value: "2"}
		dealId: utils.uuid & {_, #type: "deal", #value: "2"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "2"}
	}
	engagementDeal3: {
		id: utils.uuid & {_, #type: "engagementdeal", #value: "3"}
		dealId: utils.uuid & {_, #type: "deal", #value: "3"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "3"}
	}
}

EngagementDeal: {
	items: [
		for k, v in #EngagementDeal {
			v
		},
	]
}
