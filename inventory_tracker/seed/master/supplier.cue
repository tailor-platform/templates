package master

import (
	"tailor.build/template/seed/utils"
)

#Suppliers: {
	Supplier1: {
		id: utils.uuid & {_, #type: "supplier", #value: "1"}
		code:          1001
		name:          "GreenTech Solutions"
		contactNumber: "212-555-1234"
		email:         "contact@greentech.com"
		address:       "123 Main St, New York, NY 10001"
	}
	Supplier2: {
		id: utils.uuid & {_, #type: "supplier", #value: "2"}
		code:          1002
		name:          "Atlas Industrial Supply"
		contactNumber: "212-555-2345"
		email:         "info@atlasindustrial.com"
		address:       "456 Broadway, New York, NY 10002"
	}
	Supplier3: {
		id: utils.uuid & {_, #type: "supplier", #value: "3"}
		code:          1003
		name:          "Riverside Textiles"
		contactNumber: "212-555-3456"
		email:         "sales@riversidetextiles.com"
		address:       "789 Park Ave, New York, NY 10003"
	}
	Supplier4: {
		id: utils.uuid & {_, #type: "supplier", #value: "4"}
		code:          1004
		name:          "Nova Electronics"
		contactNumber: "212-555-4567"
		email:         "support@novaelectronics.com"
		address:       "012 Lexington Ave, New York, NY 10004"
	}
	Supplier5: {
		id: utils.uuid & {_, #type: "supplier", #value: "5"}
		code:          1005
		name:          "Prime Building Materials"
		contactNumber: "212-555-5678"
		email:         "prime@buildingmaterials.com"
		address:       "345 6th Ave, New York, NY 10005"
	}
}

Supplier: {
	items: [
		for k, v in #Suppliers {
			v
		},
	]
}
