package master

import (
	"tailor.build/template/seed/utils"
)

#items: {
	Contact1: {
		id: utils.uuid & {_, #type: "Contact", #value: "1"}
		name:         "John Doe"
		email:        "john.doe@example.com"
		phone:        "123-456-7890"
		address1:     "123 Main Street"
		address2:     null
		city:         "New York"
		province:     "New York"
		country:      "USA"
		zip:          "10001"
		countryCode:  "US"
		company:      "ABC Company"
		provinceCode: "NY"
	}
	Contact2: {
		id: utils.uuid & {_, #type: "Contact", #value: "2"}
		name:         "Jane Smith"
		email:        "jane.smith@example.com"
		phone:        "555-555-5555"
		address1:     "456 Elm Street"
		address2:     "Apt 2B"
		city:         "Los Angeles"
		province:     "California"
		country:      "USA"
		zip:          "90001"
		countryCode:  "US"
		company:      "XYZ Corp"
		provinceCode: "CA"
	}
	Contact3: {
		id: utils.uuid & {_, #type: "Contact", #value: "3"}
		name:         "Alice Johnson"
		email:        "alice.johnson@exampl.com"
		phone:        "111-222-3333"
		address1:     "789 Oak Street"
		address2:     null
		city:         "Chicago"
		province:     "Illinois"
		country:      "USA"
		zip:          "60001"
		countryCode:  "US"
		company:      "123 Inc"
		provinceCode: "IL"
	}
}

Contact: {
	items: [
		for k, v in #items {
			v
		},
	]
}
