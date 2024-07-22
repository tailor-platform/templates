package master

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	supplier1: {
		id: utils.Uuid & {_, #type: "Supplier", #value: "1"}
		code:          4001
		name:          "Fashion Supplier"
		contactNumber: "555-1111"
		email:         "info@fashionsupplier.com"
		address:       "111 Fashion Ave, City"
	}
	supplier2: {
		id: utils.Uuid & {_, #type: "Supplier", #value: "2"}
		code:          4002
		name:          "Tech Supplier"
		contactNumber: "555-2222"
		email:         "info@techsupplier.com"
		address:       "222 Tech Rd, City"
	}
	supplier3: {
		id: utils.Uuid & {_, #type: "Supplier", #value: "3"}
		code:          4003
		name:          "Sports Supplier"
		contactNumber: "555-3333"
		email:         "info@sportssupplier.com"
		address:       "333 Sports St, City"
	}
	supplier4: {
		id: utils.Uuid & {_, #type: "Supplier", #value: "4"}
		code:          4004
		name:          "Home Supplier"
		contactNumber: "555-4444"
		email:         "info@homesupplier.com"
		address:       "444 Home Ave, City"
	}
	supplier5: {
		id: utils.Uuid & {_, #type: "Supplier", #value: "5"}
		code:          4005
		name:          "Beauty Supplier"
		contactNumber: "555-5555"
		email:         "info@beautysupplier.com"
		address:       "555 Beauty Rd, City"
	}

}

Supplier: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
