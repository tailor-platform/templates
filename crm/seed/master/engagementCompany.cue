package master

import (
	"tailor.build/template/seed/utils"
)

#EngagementCompany: {
	engagementCompany1: {
		id: utils.uuid & {_, #type: "EngagementCompany", #value: "1"}
		companyId: utils.uuid & {_, #type: "Company", #value: "1"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "1"}
	}
	engagementCompany2: {
		id: utils.uuid & {_, #type: "EngagementCompany", #value: "2"}
		companyId: utils.uuid & {_, #type: "Company", #value: "1"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "2"}
	}
	engagementCompany3: {
		id: utils.uuid & {_, #type: "EngagementCompany", #value: "2"}
		companyId: utils.uuid & {_, #type: "Company", #value: "2"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "2"}
	}
	engagementCompany4: {
		id: utils.uuid & {_, #type: "EngagementCompany", #value: "3"}
		companyId: utils.uuid & {_, #type: "Company", #value: "3"}
		engagementId: utils.uuid & {_, #type: "Engagement", #value: "3"}
	}
}

EngagementCompany: {
	items: [
		for k, v in #EngagementCompany {
			v
		}
	]
}
