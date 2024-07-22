package master

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	warehouse1: {
		id: utils.Uuid & {_, #type: "Warehouse", #value: "1"}
		code:          3001
		name:          "Main Distribution Center"
		address:       "789 Distribution Ave, City"
		type:          "Distribution"
		contactNumber: "555-6789"
	}
	warehouse2: {
		id: utils.Uuid & {_, #type: "Warehouse", #value: "2"}
		code:          3002
		name:          "Backup Warehouse"
		address:       "456 Backup St, City"
		type:          "Storage"
		contactNumber: "555-2345"
	}
	warehouse3: {
		id: utils.Uuid & {_, #type: "Warehouse", #value: "3"}
		code:          3003
		name:          "Regional Warehouse"
		address:       "123 Regional Rd, City"
		type:          "Distribution"
		contactNumber: "555-8901"
	}
	warehouse4: {
		id: utils.Uuid & {_, #type: "Warehouse", #value: "4"}
		code:          3004
		name:          "Remote Warehouse"
		address:       "012 Remote Ave, City"
		type:          "Storage"
		contactNumber: "555-4567"
	}
	warehouse5: {
		id: utils.Uuid & {_, #type: "Warehouse", #value: "5"}
		code:          3005
		name:          "Specialized Warehouse"
		address:       "345 Specialized St, City"
		type:          "Storage"
		contactNumber: "555-0123"
	}

}

Warehouse: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
