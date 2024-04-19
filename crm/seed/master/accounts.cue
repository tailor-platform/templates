package master

import (
	"tailor.build/template/seed/utils"
)

#CustomerAccounts: {
	account1: {
		id: utils.uuid & {_, #type: "customerAccount", #value: "1"}
		companyName:  "Globex Corporation"
		contact: {
			contactName:  "Hank Scorpio"
			emailAddress: "hank.scorpio@globex.com"
			phoneNumber:  "(212) 555-1234"
		}
	}
	account2: {
		id: utils.uuid & {_, #type: "customerAccount", #value: "2"}
		companyName:  "Initech"
		contact: {
			contactName:  "Bill Lumbergh"
			emailAddress: "bill.lumbergh@initech.com"
			phoneNumber:  "(310) 555-5678"
		}
	}
	account3: {
		id: utils.uuid & {_, #type: "customerAccount", #value: "3"}
		companyName:  "Vandelay Industries"
		contact: {
			contactName:  "Art Vandelay"
			emailAddress: "art.vandelay@vandelay.com"
			phoneNumber:  "(312) 555-9012"
		}
	}
}

CustomerAccount: {
	items: [
		for k, v in #CustomerAccounts {
			v
		},
	]
}
