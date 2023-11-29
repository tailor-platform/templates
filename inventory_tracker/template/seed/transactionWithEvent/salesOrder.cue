package salesOrder

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
	for k, v in _salesOrders {
		{
			query: _query
			variables: {
				id: v.id
				lotID: v.lotID
				quantity: v.quantity
				salesOrderDate: v.salesOrderDate
                customerName: v.customerName
                deliveryAddress: v.deliveryAddress
			}
		}
	},
]

_query: """
mutation (
    $id: ID,
    $lotID: ID!,
    $quantity: Int!,
    $salesOrderDate: Date!,
    $customerName: String,
    $deliveryAddress: String
    ) {
        purchaseOrder1: createSalesOrder(
            input: {
                id: $id
                lotID: $lotID
                quantity: $quantity
                salesOrderDate: $salesOrderDate
                customerName: $customerName
                deliveryAddress: $deliveryAddress
            }
        ) {
            id
        }
    }"""

_salesOrders: {
    SalesOrder101: {
        id: {{ generateApplicationUUID "salesOrder-101" | quote }},
        lotID: {{ generateApplicationUUID "lot-101" | quote }},
        quantity: 5,
        salesOrderDate: "2023-11-10",
        customerName: "Paul Smith Jr.",
        deliveryAddress: "123 Main St, New York, NY 10001"
    }
}
