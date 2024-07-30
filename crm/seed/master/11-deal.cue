package master

import (
	"tailor.build/template/seed/utils"
)

#Deal: {
	deal0: {
		id: utils.uuid & {_, #type: "deal", #value: "1"}
		amount:      10000.5
		probability: 0.75
		value:       15000.75
		isDeleted:   false
		dealStageId: utils.uuid & {_, #type: "dealstage", #value: "1"}
		userId: utils.uuid & {_, #type: "user", #value: "1"}
		companyId: utils.uuid & {_, #type: "company", #value: "1"}
		contactId: utils.uuid & {_, #type: "contact", #value: "1"}
	}
	deal1: {
		id: utils.uuid & {_, #type: "deal", #value: "2"}
		amount:      7500.25
		probability: 0.4
		value:       8000.9
		isDeleted:   true
		dealStageId: utils.uuid & {_, #type: "dealstage", #value: "2"}
		userId: utils.uuid & {_, #type: "user", #value: "3"}
		companyId: utils.uuid & {_, #type: "company", #value: "2"}
		contactId: utils.uuid & {_, #type: "contact", #value: "2"}
	}
	deal2: {
		id: utils.uuid & {_, #type: "deal", #value: "3"}
		amount:      5000.75
		probability: 0.6
		value:       7000.25
		isDeleted:   false
		dealStageId: utils.uuid & {_, #type: "dealstage", #value: "3"}
		userId: utils.uuid & {_, #type: "user", #value: "3"}
		companyId: utils.uuid & {_, #type: "company", #value: "3"}
		contactId: utils.uuid & {_, #type: "contact", #value: "3"}
	}
	deal3: {
		id: utils.uuid & {_, #type: "deal", #value: "4"}
		amount:      10000.5
		probability: 0.6
		value:       15000.75
		isDeleted:   false
		dealStageId: utils.uuid & {_, #type: "dealstage", #value: "5"}
		userId: utils.uuid & {_, #type: "user", #value: "1"}
		companyId: utils.uuid & {_, #type: "company", #value: "1"}
		contactId: utils.uuid & {_, #type: "contact", #value: "1"}
	}
	deal4: {
		id: utils.uuid & {_, #type: "deal", #value: "5"}
		amount:      5000.75
		probability: 0.6
		value:       7000.25
		isDeleted:   false
		dealStageId: utils.uuid & {_, #type: "dealstage", #value: "6"}
		userId: utils.uuid & {_, #type: "user", #value: "3"}
		companyId: utils.uuid & {_, #type: "company", #value: "3"}
		contactId: utils.uuid & {_, #type: "contact", #value: "3"}
	}
}

Deal: {
	items: [
		for k, v in #Deal {
			v
		},
	]
}
