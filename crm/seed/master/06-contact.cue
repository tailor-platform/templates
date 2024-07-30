package master

import (
	"tailor.build/template/seed/utils"
)

#Contact: {
	contact0: {
		id: utils.uuid & {_, #type: "contact", #value: "1"}
		firstName:    "Alice"
		lastName:     "Smith"
		email:        "alice.smith@example.com"
		phonePrimary: "123-456-7890"
		linkedInUrl:  "linkedin.com/alice-smith"
		companyId: utils.uuid & {_, #type: "company", #value: "1"}
	}
	contact1: {
		id: utils.uuid & {_, #type: "contact", #value: "2"}
		firstName:    "Bob"
		lastName:     "Johnson"
		email:        "bob.johnson@example.com"
		phonePrimary: "987-654-3210"
		linkedInUrl:  "linkedin.com/bob-johnson"
		companyId: utils.uuid & {_, #type: "company", #value: "2"}
	}
	contact2: {
		id: utils.uuid & {_, #type: "contact", #value: "3"}
		firstName:    "Eve"
		lastName:     "Williams"
		email:        "eve.williams@example.com"
		phonePrimary: "456-123-7890"
		linkedInUrl:  "linkedin.com/eve-williams"
		companyId: utils.uuid & {_, #type: "company", #value: "3"}
	}
}

Contact: {
	items: [
		for k, v in #Contact {
			v
		},
	]
}
