package master

import (
	"tailor.build/template/seed/utils"
)

#ContactList: {
	contactList0: {
		id: utils.uuid & {_, #type: "contactlist", #value: "1"}
		isDeleted: false
		name:      "Online Source Contacts List"
	}
	contactList1: {
		id: utils.uuid & {_, #type: "contactlist", #value: "2"}
		isDeleted: true
		name:      "Referral Contacts List"
	}
	contactList2: {
		id: utils.uuid & {_, #type: "contactlist", #value: "3"}
		isDeleted: false
		name:      "Organic Contacts List"
	}
}

ContactList: {
	items: [
		for k, v in #ContactList {
			v
		},
	]
}
