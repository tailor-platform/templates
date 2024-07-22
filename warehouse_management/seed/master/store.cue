package master

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	Store1: {
		id: utils.Uuid & {_, #type: "Store", #value: "1"}
		code:          2001
		name:          "Main Street Store"
		address:       "123 Main St, City"
		type:          "Retail"
		contactNumber: "555-1234"
	}
	Store2: {
		id: utils.Uuid & {_, #type: "Store", #value: "2"}
		code:          2002
		name:          "Mall Store"
		address:       "456 Mall Ave, City"
		type:          "Retail"
		contactNumber: "555-5678"
	}
	Store3: {
		id: utils.Uuid & {_, #type: "Store", #value: "3"}
		code:          2003
		name:          "Outlet Store"
		address:       "789 Outlet Rd, City"
		type:          "Retail"
		contactNumber: "555-9012"
	}
	Store4: {
		id: utils.Uuid & {_, #type: "Store", #value: "4"}
		code:          2005
		name:          "Pop-Up Store"
		address:       "321 Pop-Up St, City"
		type:          "Retail"
		contactNumber: "555-7890"
	}
}

Store: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
