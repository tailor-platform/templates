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

}

Contact: {
	items: [
		for k, v in #items {
			v
		},
	]
}
