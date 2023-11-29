package shipOutWithEvent

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
				quantity: v.quantity
				shipOutDate: v.shipOutDate
				salesOrderID: v.salesOrderID
			}
		}
	},
]

_query: """
mutation (
    $quantity: Int!,
    $shipOutDate: Date!,
    $salesOrderID: ID!,
    ) {
        shipOut101: createShipOutWithEvent(
            input: {
                quantity: $quantity
                shipOutDate:$shipOutDate
                salesOrderID: $salesOrderID
            }
        )
    }"""

_shipOuts: {
    ShipOut101: {
        quantity: 5,
        shipOutDate: "2023-11-11",
        salesOrderID: {{ generateApplicationUUID "salesOrder-101" | quote }}
    }
}
