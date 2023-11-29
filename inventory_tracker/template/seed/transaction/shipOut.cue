package shipOut

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
	for k, v in _shipOuts {
		{
			query: _query
			variables: {
				id: v.id
				quantity: v.quantity
				shipOutDate: v.shipOutDate
				salesOrderID: v.salesOrderID
			}
		}
	},
]

_query: """
mutation (
    $id: ID,
    $quantity: Int!,
    $shipOutDate: Date!,
    $salesOrderID: ID!,
    ) {
        shipOut1: createShipOut(
            input: {
                id: $id
                quantity: $quantity
                shipOutDate:$shipOutDate
                salesOrderID: $salesOrderID
            }
        ) {
            id
        }
    }"""

_shipOuts: {
    ShipOut1: {
        id: {{ generateApplicationUUID "shipOut-1" | quote }},
        quantity: 5,
        shipOutDate: "2023-11-11",
        salesOrderID: {{ generateApplicationUUID "salesOrder-1" | quote }}
    },
    ShipOut2: {
        id: {{ generateApplicationUUID "shipOut-2" | quote }},
        quantity: 10,
        shipOutDate: "2023-11-11",
        salesOrderID: {{ generateApplicationUUID "salesOrder-2" | quote }}
    },
    ShipOut3: {
        id: {{ generateApplicationUUID "shipOut-3" | quote }},
        quantity: 2,
        shipOutDate: "2023-11-12",
        salesOrderID: {{ generateApplicationUUID "salesOrder-3" | quote }}
    },
    ShipOut4: {
        id: {{ generateApplicationUUID "shipOut-4" | quote }},
        quantity: 5,
        shipOutDate: "2023-11-13",
        salesOrderID: {{ generateApplicationUUID "salesOrder-4" | quote }}
    },
    ShipOut5: {
        id: {{ generateApplicationUUID "shipOut-5" | quote }},
        quantity: 1,
        shipOutDate: "2023-11-14",
        salesOrderID: {{ generateApplicationUUID "salesOrder-5" | quote }}
    },
    ShipOut6: {
        id: {{ generateApplicationUUID "shipOut-6" | quote }},
        quantity: 1,
        shipOutDate: "2023-11-15",
        salesOrderID: {{ generateApplicationUUID "salesOrder-6" | quote }}
    },
    ShipOut7: {
        id: {{ generateApplicationUUID "shipOut-7" | quote }},
        quantity: 10,
        shipOutDate: "2023-11-16",
        salesOrderID: {{ generateApplicationUUID "salesOrder-7" | quote }}
    },
    ShipOut8: {
        id: {{ generateApplicationUUID "shipOut-8" | quote }},
        quantity: 3,
        shipOutDate: "2023-11-17",
        salesOrderID: {{ generateApplicationUUID "salesOrder-8" | quote }}
    },
    ShipOut9: {
        id: {{ generateApplicationUUID "shipOut-9" | quote }},
        quantity: 3,
        shipOutDate: "2023-11-18",
        salesOrderID: {{ generateApplicationUUID "salesOrder-9" | quote }}
    },
    ShipOut10: {
        id: {{ generateApplicationUUID "shipOut-10" | quote }},
        quantity: 5,
        shipOutDate: "2023-11-19",
        salesOrderID: {{ generateApplicationUUID "salesOrder-10" | quote }}
    }
}
