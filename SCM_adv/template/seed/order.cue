package order

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
	for k, v in orders {
		{
			query: """
      mutation placeOrder(
        $quantity: Int!
        $placedDate: Date!
        $productID: ID!
        $locationID: ID!
      ) {
        placeOrder(
          input: {
            quantity: $quantity
            locationID: $locationID
            placedDate: $placedDate
            productID: $productID
          }
        ) {
          id
        }
      }
      """
			variables: {
        quantity: v.quantity
        placedDate: v.placedDate
        productID: v.productID
        locationID: v.locationID
			}
		}
	},
]

orders: {
	order1: {
    quantity: 2
    placedDate: "2023-01-01"
    productID: constant.uuid & {_, #type: "product", #value: "1"}
    locationID: constant.uuid & {_, #type: "location", #value: "1"}
	}

  order2: {
    quantity: 3
    placedDate: "2023-01-02"
    productID: constant.uuid & {_, #type: "product", #value: "2"}
    locationID: constant.uuid & {_, #type: "location", #value: "2"}
  }
  

}



