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
        purchaseOrder1: createPurchaseOrder(
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
    PurchaseOrder1: {
        id: {{ generateApplicationUUID "purchaseOrder-1" | quote }},
        productID: {{ generateApplicationUUID "product-1" | quote }},
        locationID: {{ generateApplicationUUID "location-1" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-1" | quote }},
        quantity: 10,
        purchaseOrderDate: "2023-11-01"
    },
    PurchaseOrder2: {
        id: {{ generateApplicationUUID "purchaseOrder-2" | quote }},
        productID: {{ generateApplicationUUID "product-1" | quote }},
        locationID: {{ generateApplicationUUID "location-2" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-1" | quote }},
        quantity: 10,
        purchaseOrderDate: "2023-11-01"
    },
    PurchaseOrder3: {
        id: {{ generateApplicationUUID "purchaseOrder-3" | quote }},
        productID: {{ generateApplicationUUID "product-1" | quote }},
        locationID: {{ generateApplicationUUID "location-3" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-2" | quote }},
        quantity: 20,
        purchaseOrderDate: "2023-11-01"
    },
    PurchaseOrder4: {
        id: {{ generateApplicationUUID "purchaseOrder-4" | quote }},
        productID: {{ generateApplicationUUID "product-1" | quote }},
        locationID: {{ generateApplicationUUID "location-4" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-1" | quote }},
        quantity: 9,
        purchaseOrderDate: "2023-11-01"
    },
    PurchaseOrder5: {
        id: {{ generateApplicationUUID "purchaseOrder-5" | quote }},
        productID: {{ generateApplicationUUID "product-2" | quote }},
        locationID: {{ generateApplicationUUID "location-1" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-2" | quote }},
        quantity: 18,
        purchaseOrderDate: "2023-11-02"
    },
    PurchaseOrder6: {
        id: {{ generateApplicationUUID "purchaseOrder-6" | quote }},
        productID: {{ generateApplicationUUID "product-3" | quote }},
        locationID: {{ generateApplicationUUID "location-1" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-1" | quote }},
        quantity: 70,
        purchaseOrderDate: "2023-11-03"
    },
    PurchaseOrder7: {
        id: {{ generateApplicationUUID "purchaseOrder-7" | quote }},
        productID: {{ generateApplicationUUID "product-4" | quote }},
        locationID: {{ generateApplicationUUID "location-1" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-1" | quote }},
        quantity: 3,
        purchaseOrderDate: "2023-11-04"
    },
    PurchaseOrder8: {
        id: {{ generateApplicationUUID "purchaseOrder-8" | quote }},
        productID: {{ generateApplicationUUID "product-5" | quote }},
        locationID: {{ generateApplicationUUID "location-1" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-2" | quote }},
        quantity: 12,
        purchaseOrderDate: "2023-11-05"
    },
    PurchaseOrder9: {
        id: {{ generateApplicationUUID "purchaseOrder-9" | quote }},
        productID: {{ generateApplicationUUID "product-3" | quote }},
        locationID: {{ generateApplicationUUID "location-2" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-1" | quote }},
        quantity: 50,
        purchaseOrderDate: "2023-11-06"
    },
    PurchaseOrder10: {
        id: {{ generateApplicationUUID "purchaseOrder-10" | quote }},
        productID: {{ generateApplicationUUID "product-4" | quote }},
        locationID: {{ generateApplicationUUID "location-2" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-2" | quote }},
        quantity: 2,
        purchaseOrderDate: "2023-11-07"
    },
    PurchaseOrder11: {
        id: {{ generateApplicationUUID "purchaseOrder-11" | quote }},
        productID: {{ generateApplicationUUID "product-5" | quote }},
        locationID: {{ generateApplicationUUID "location-2" | quote }},
        supplierID: {{ generateApplicationUUID "supplier-2" | quote }},
        quantity: 9,
        purchaseOrderDate: "2023-11-08"
    }
}
