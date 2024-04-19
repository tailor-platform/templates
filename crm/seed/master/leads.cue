package master

import (
	"tailor.build/template/seed/utils"
)


#Leads: {
	lead1: {
		id: utils.uuid & {_, #type: "lead", #value: "1"}
		companyName:  "Duff Beer"
		leadSource:   "Trade Show"
		stage:        "Open"
		dealAmount:   "4500"
		contact: {
			contactName:  "Duffman"
			emailAddress: "duffman@duffbeer.com"
			phoneNumber:  "(702) 555-3456"
		}
	}
	lead2: {
		id: utils.uuid & {_, #type: "lead", #value: "2"}
		companyName:  "Acme Corp"
		leadSource:   "Referral"
		stage:        "WIP"
		dealAmount:   "12000"
		contact: {
			contactName:  "Wile E. Coyote"
			emailAddress: "w.coyote@acme.com"
			phoneNumber:  "(305) 555-7890"
		}
	}
	lead3: {
		id: utils.uuid & {_, #type: "lead", #value: "3"}
		companyName:  "Bluth Company"
		leadSource:   "Website"
		stage:        "Won"
		dealAmount:   "25000"
		contact: {
			contactName:  "Michael Bluth"
			emailAddress: "michael@bluth.com"
			phoneNumber:  "(512) 555-1234"
		}
	}
	lead4: {
		id: utils.uuid & {_, #type: "lead", #value: "4"}
		companyName:  "Wonka Industries"
		leadSource:   "Email"
		stage:        "Lost"
		dealAmount:   "6000"
		contact: {
			contactName:  "Willy Wonka"
			emailAddress: "w.wonka@wonka.com"
			phoneNumber:  "(415) 555-5678"
		}
	}
}

Lead: {
	items: [
		for k, v in #Leads {
			v
		},
	]
}
