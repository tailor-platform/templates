package purchase

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGraphqlSeed
	spec:    manifest.#SpecGraphqlSeed & {
		mutations: mutationList
	}
}

let mutationList = [
	for k, v in purchases {
		{
			query: """
				     mutation placePurchase(
				       $quantity: Int!
				       $placedDate: Date!
				       $productID: ID!
				       $locationID: ID!
				     ) {
				       placePurchase(
				         input: {
				           quantity: $quantity
				           locationID: $locationID
				           placedDate: $placedDate
				           productID: $productID
				         }
				       ) {
				         id
				       }
				     }"""
			variables: {
				quantity:   v.quantity
				placedDate: v.placedDate
				productID:  v.productID
				locationID: v.locationID
			}
		}
	},
]

purchases: {
	order1: {
		quantity:   15
		placedDate: "2023-01-01"
		productID:  "74bd759c-75b8-5608-be49-22f6ec34c9e6"
		locationID: "ab2a38d3-bdad-5536-ac94-99474bcd0245"
	}

	order2: {
		quantity:   8
		placedDate: "2023-01-02"
		productID:  "1889c64a-3b7f-546a-87e5-cc2f03815e99"
		locationID: "821efdc7-4dea-58ac-9868-40abad8cae66"
	}

}
