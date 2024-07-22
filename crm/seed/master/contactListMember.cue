package master

import (
	"tailor.build/template/seed/utils"
)

#ContactListMember: {
	contactListMember0: {
		id: utils.uuid & {_, #type: "ContactListMember", #value: "1"}
		contactId: utils.uuid & {_, #type: "Contact", #value: "1"}
		contactListId: utils.uuid & {_, #type: "ContactList", #value: "1"}
		addedAt: "2022-06-15"
	}
	contactListMember1: {
		id: utils.uuid & {_, #type: "ContactListMember", #value: "2"}
		contactId: utils.uuid & {_, #type: "Contact", #value: "2"}
		contactListId: utils.uuid & {_, #type: "ContactList", #value: "2"}
		addedAt: "2022-07-20"
	}
	contactListMember2: {
		id: utils.uuid & {_, #type: "ContactListMember", #value: "3"}
		contactId: utils.uuid & {_, #type: "Contact", #value: "3"}
		contactListId: utils.uuid & {_, #type: "ContactList", #value: "3"}
		addedAt: "2022-08-25"
	}
}

ContactListMember: {
	items: [
		for k, v in #ContactListMember {
			v
		}
	]
}
