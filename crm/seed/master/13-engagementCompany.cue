package master

import (
	"tailor.build/template/seed/utils"
)

#EngagementCompany: {
	engagementCompany1: {
		id: utils.uuid & {_, #type: "engagementcompany", #value: "1"}
		companyId: utils.uuid & {_, #type: "company", #value: "1"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "1"}
	}
	engagementCompany2: {
		id: utils.uuid & {_, #type: "engagementcompany", #value: "2"}
		companyId: utils.uuid & {_, #type: "company", #value: "1"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "2"}
	}
	engagementCompany3: {
		id: utils.uuid & {_, #type: "engagementcompany", #value: "3"}
		companyId: utils.uuid & {_, #type: "company", #value: "2"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "2"}
	}
	engagementCompany4: {
		id: utils.uuid & {_, #type: "engagementcompany", #value: "4"}
		companyId: utils.uuid & {_, #type: "company", #value: "3"}
		engagementId: utils.uuid & {_, #type: "engagement", #value: "3"}
	}
}

EngagementCompany: {
	items: [
		for k, v in #EngagementCompany {
			v
		},
	]
}
