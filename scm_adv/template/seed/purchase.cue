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
				       )
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
		productID:  {{ generateApplicationUUID "Product1" | quote }}
		locationID: {{ generateApplicationUUID "Location1" | quote }}
	}

	order2: {
		quantity:   8
		placedDate: "2023-01-02"
		productID:  {{ generateApplicationUUID "Product2" | quote }}
		locationID: {{ generateApplicationUUID "Location2" | quote }}
	}

}
