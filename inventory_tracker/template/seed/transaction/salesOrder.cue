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
    SalesOrder1: {
        id: {{ generateApplicationUUID "salesOrder-1" | quote }},
        lotID: {{ generateApplicationUUID "lot-1" | quote }},
        quantity: 5,
        salesOrderDate: "2023-11-10",
        customerName: "Paul Smith",
        deliveryAddress: "123 Main St, New York, NY 10001"
    },
    SalesOrder2: {
        id: {{ generateApplicationUUID "salesOrder-2" | quote }},
        lotID: {{ generateApplicationUUID "lot-2" | quote }},
        quantity: 10,
        salesOrderDate: "2023-11-11",
        customerName: "John Doe",
        deliveryAddress: "456 Oak St, Los Angeles, CA 90001"
    },
    SalesOrder3: {
        id: {{ generateApplicationUUID "salesOrder-3" | quote }},
        lotID: {{ generateApplicationUUID "lot-3" | quote }},
        quantity: 2,
        salesOrderDate: "2023-11-12",
        customerName: "Jane Doe",
        deliveryAddress: "789 Pine St, Chicago, IL 60601"
    },
    SalesOrder4: {
        id: {{ generateApplicationUUID "salesOrder-4" | quote }},
        lotID: {{ generateApplicationUUID "lot-4" | quote }},
        quantity: 5,
        salesOrderDate: "2023-11-13",
        customerName: "Mary Johnson",
        deliveryAddress: "321 Elm St, Houston, TX 77001"
    },
    SalesOrder5: {
        id: {{ generateApplicationUUID "salesOrder-5" | quote }},
        lotID: {{ generateApplicationUUID "lot-5" | quote }},
        quantity: 1,
        salesOrderDate: "2023-11-14",
        customerName: "James Brown",
        deliveryAddress: "654 Maple St, Philadelphia, PA 19101"
    },
    SalesOrder6: {
        id: {{ generateApplicationUUID "salesOrder-6" | quote }},
        lotID: {{ generateApplicationUUID "lot-6" | quote }},
        quantity: 1,
        salesOrderDate: "2023-11-15",
        customerName: "Patricia Davis",
        deliveryAddress: "987 Cedar St, Phoenix, AZ 85001"
    },
    SalesOrder7: {
        id: {{ generateApplicationUUID "salesOrder-7" | quote }},
        lotID: {{ generateApplicationUUID "lot-7" | quote }},
        quantity: 10,
        salesOrderDate: "2023-11-16",
        customerName: "Robert Miller",
        deliveryAddress: "147 Spruce St, San Antonio, TX 78201"
    },
    SalesOrder8: {
        id: {{ generateApplicationUUID "salesOrder-8" | quote }},
        lotID: {{ generateApplicationUUID "lot-8" | quote }},
        quantity: 3,
        salesOrderDate: "2023-11-17",
        customerName: "Linda Wilson",
        deliveryAddress: "258 Birch St, San Diego, CA 92101"
    },
    SalesOrder9: {
        id: {{ generateApplicationUUID "salesOrder-9" | quote }},
        lotID: {{ generateApplicationUUID "lot-9" | quote }},
        quantity: 3,
        salesOrderDate: "2023-11-18",
        customerName: "Michael Moore",
        deliveryAddress: "369 Walnut St, Dallas, TX 75201"
    },
    SalesOrder10: {
        id: {{ generateApplicationUUID "salesOrder-10" | quote }},
        lotID: {{ generateApplicationUUID "lot-10" | quote }},
        quantity: 5,
        salesOrderDate: "2023-11-19",
        customerName: "Elizabeth Taylor",
        deliveryAddress: "963 Aspen St, San Jose, CA 95101"
    }
}
