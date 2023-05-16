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
		name:     "Globex Corporation"
		country:  "USA"
		city:     "New York"
		address1: "123 Liberty St"
		address2: "Floor 27"
		zipcode:  "10006"
	}
	location2: {
		id:   {{ generateWorkspaceUUID "Location2" | quote }}
		code:     2
		name:     "Soylent Corp"
		country:  "USA"
		city:     "Los Angeles"
		address1: "456 Sunset Blvd"
		address2: "Suite 830"
		zipcode:  "90028"
	}
	location3: {
		id:   {{ generateWorkspaceUUID "Location3" | quote }}
		code:     3
		name:     "Initech"
		country:  "USA"
		city:     "Chicago"
		address1: "789 Michigan Ave"
		address2: "Building B"
		zipcode:  "60611"
	}
}
