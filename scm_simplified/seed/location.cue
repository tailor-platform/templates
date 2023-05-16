package location

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGraphqlSeed
	spec:    manifest.#SpecGraphqlSeed & {
		mutations: mutationList
	}
}

let mutationList = [
	for k, v in locations {
		{
			query: """
			mutation (
				$id: ID, 
				$code: Int,
				$name: String,
				$country: String,
				$city: String,
				$address1: String,
				$address2: String,
				$zipcode: String
				) {
					location1: createLocation(
						input: {
							id: $id
							locationCode: $code
							locationName: $name
							country: $country
							city: $city
							address1: $address1
							address2: $address2
							zipcode: $zipcode
						}
						) {
							id
						}
					}
					"""
			variables: {
				id:       v.id
				code:     v.code
				name:     v.name
				country:  v.country
				city:     v.city
				address1: v.address1
				address2: v.address2
				zipcode:  v.zipcode
			}
		}
	},
]

locations: {
	location1: {
		id:    {{ generateWorkspaceUUID "Location1" | quote }}
		code:     1
		name:     "Vandelay Industries"
		country:  "USA"
		city:     "New York"
		address1: "129 West 81st Street"
		address2: "Floor 5, Suite A"
		zipcode:  "10024"
	}
	location2: {
		id:   {{ generateWorkspaceUUID "Location2" | quote }}
		code:     2
		name:     "Satriale's Pork Store"
		country:  "USA"
		city:     "Kearny"
		address1: "101 Kearny Ave"
		address2: "Building B, Unit 3"
		zipcode:  "07032"
	}
	location3: {
		id:   {{ generateWorkspaceUUID "Location3" | quote }}
		code:     3
		name:     "Los Pollos Hermanos"
		country:  "USA"
		city:     "Albuquerque"
		address1: "308 98th St SW"
		address2: "Building C, Unit 7"
		zipcode:  "87121"
	}
}
