package master

import "tailor.build/template/seed/utils"

#Suppliers: {
	Supplier1: {
		id: utils.uuid & {_, #type: "supplier", #value: "0001"}
		code:          "SUP0001"
		name:          "John Smith"
		email:         "john@example.com"
		companyName:   "John Smith Ltd"
		contactNumber: "+1 (555) 1234-56789"
		address:       "1234 Elm Street, Springfield, IL 62701"
		status:        "active"
	}
	Supplier2: {
		id: utils.uuid & {_, #type: "supplier", #value: "0002"}
		code:          "SUP0002"
		name:          "Jane Doe"
		email:         "jane@example.com"
		companyName:   "Doe Enterprises"
		contactNumber: "+1 (555) 2345-67890"
		address:       "5678 Oak Street, Springfield, IL 62702"
		status:        "active"
	}
	Supplier3: {
		id: utils.uuid & {_, #type: "supplier", #value: "0003"}
		code:          "SUP0003"
		name:          "Bob Johnson"
		email:         "bob@example.com"
		companyName:   "Johnson & Sons"
		contactNumber: "+1 (555) 3456-78901"
		address:       "9101 Pine Street, Springfield, IL 62703"
		status:        "active"
	}
	Supplier4: {
		id: utils.uuid & {_, #type: "supplier", #value: "0004"}
		code:          "SUP0004"
		name:          "Alice Williams"
		email:         "alice@example.com"
		companyName:   "Williams Industries"
		contactNumber: "+1 (555) 4567-89012"
		address:       "1213 Maple Street, Springfield, IL 62704"
		status:        "active"
	}
	Supplier5: {
		id: utils.uuid & {_, #type: "supplier", #value: "0005"}
		code:          "SUP0005"
		name:          "Charlie Brown"
		email:         "charlie@example.com"
		companyName:   "Brown Corp"
		contactNumber: "+1 (555) 5678-90123"
		address:       "1415 Birch Street, Springfield, IL 62705"
		status:        "active"
	}
	Supplier6: {
		id: utils.uuid & {_, #type: "supplier", #value: "0006"}
		code:          "SUP0006"
		name:          "David Davis"
		email:         "david@example.com"
		companyName:   "Davis & Co"
		contactNumber: "+1 (555) 6789-01234"
		address:       "1617 Cedar Street, Springfield, IL 62706"
		status:        "active"
	}
	Supplier7: {
		id: utils.uuid & {_, #type: "supplier", #value: "0007"}
		code:          "SUP0007"
		name:          "Emily Evans"
		email:         "emily@example.com"
		companyName:   "Evans Enterprises"
		contactNumber: "+1 (555) 7890-12345"
		address:       "1819 Dogwood Street, Springfield, IL 62707"
		status:        "active"
	}
	Supplier8: {
		id: utils.uuid & {_, #type: "supplier", #value: "0008"}
		code:          "SUP0008"
		name:          "Frank Foster"
		email:         "frank@example.com"
		companyName:   "Foster & Sons"
		contactNumber: "+1 (555) 8901-23456"
		address:       "2021 Elm Street, Springfield, IL 62708"
		status:        "active"
	}
	Supplier9: {
		id: utils.uuid & {_, #type: "supplier", #value: "0009"}
		code:          "SUP0009"
		name:          "Grace Green"
		email:         "grace@example.com"
		companyName:   "Green Industries"
		contactNumber: "+1 (555) 9012-34567"
		address:       "2223 Oak Street, Springfield, IL 62709"
		status:        "active"
	}
	Supplier10: {
		id: utils.uuid & {_, #type: "supplier", #value: "0010"}
		code:          "SUP0010"
		name:          "Henry Harris"
		email:         "henry@example.com"
		companyName:   "Harris & Co"
		contactNumber: "+1 (555) 0123-45678"
		address:       "2425 Pine Street, Springfield, IL 62710"
		status:        "active"
	}
}

Supplier: {
	items: [
		for k, v in #Suppliers {
			v
		},
	]
}
