package purchaseOrder

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
	for k, v in purchaseOrders {
		{
			query: _query
			variables: {
				id:       v.id
				productID: v.productID
				locationID: v.locationID
				supplierID: v.supplierID
				quantity: v.quantity
				purchaseOrderDate: v.purchaseOrderDate
			}
		}
	},
]

_query: """
mutation (
    $id: ID,
    $productID: ID!
    $locationID: ID!
    $supplierID: ID!
    $quantity: Int!
    $purchaseOrderDate: Date!
    ) {
        purchaseOrder101: createPurchaseOrder(
            input: {
                id: $id
                productID: $productID
                locationID: $locationID
                supplierID: $supplierID
                quantity: $quantity
                purchaseOrderDate: $purchaseOrderDate
        }
        ) {
            id
        }
    }"""    

purchaseOrders: {
    PurchaseOrder101: {
        id: {{ generateApplicationUUID "purchaseOrder-101" | quote }},
        productID: {{ generateApplicationUUID "product-1" | quote }},
        locationID: {{ generateApplicationUUID "location-1" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-1" | quote }},
        quantity: 10,
        purchaseOrderDate: "2023-11-02"
    },
    PurchaseOrder102: {
        id: {{ generateApplicationUUID "purchaseOrder-102" | quote }},
        productID: {{ generateApplicationUUID "product-1" | quote }},
        locationID: {{ generateApplicationUUID "location-2" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-1" | quote }},
        quantity: 10,
        purchaseOrderDate: "2023-11-02"
    }
}
