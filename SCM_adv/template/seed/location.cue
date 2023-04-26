package location

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"{{ .Values.cue.package }}/charts/common:constant"
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
      }"""
			variables: {
        id: v.id
        code: v.code
        name: v.name
        country: v.country
        city: v.city
        address1: v.address1
        address2: v.address2
        zipcode: v.zipcode
			}
		}
	},
]

locations: {
	location1: {
		id:   constant.uuid & {_, #type: "location", #value: "1"}
    code: 1
    name: "location1"
    country: "USA"
    city: "New York"
    address1: "address1"
    address2: "address2"
    zipcode: "12345"
	}
	location2: {
		id:   constant.uuid & {_, #type: "location", #value: "2"}
    code: 2
    name: "location2"
    country: "USA"
    city: "Los Angeles"
    address1: "address1"
    address2: "address2"
    zipcode: "54321"
	}
	location3: {
		id:   constant.uuid & {_, #type: "location", #value: "3"}
    code: 3
    name: "location3"
    country: "USA"
    city: "Chicago"
    address1: "address1"
    address2: "address2"
    zipcode: "23455"
	}
}



