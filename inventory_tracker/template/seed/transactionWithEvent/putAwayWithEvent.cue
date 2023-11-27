package putAwayWithEvent

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
	for k, v in _putAways {
		{
			query: _query
			variables: {
				id: v.id
				purchaseOrderID: v.purchaseOrderID
				quantity: v.quantity
				putAwayDate: v.putAwayDate
                lotID: v.lotID
			}
		}
	},
]

_query: """
mutation (
    $id: ID,
    $purchaseOrderID: ID!,
    $quantity: Int!,
    $putAwayDate: Date!,
    $lotID: ID
    ) {
        putAway101: createPutAwayWithEvent(
            input: {
                id: $id
                purchaseOrderID: $purchaseOrderID
                quantity: $quantity
                putAwayDate:$putAwayDate
                lotID: $lotID
            }
        )
    }"""

_putAways: {
    PutAway101: {
        id: {{ generateApplicationUUID "putAway-101" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-101" | quote }},
        lotID: {{ generateApplicationUUID "lot-101" | quote }},
        quantity: 8,
        putAwayDate: "2023-11-02"
    },
    PutAway102: {
        id: {{ generateApplicationUUID "putAway-102" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-102" | quote }},
        lotID: {{ generateApplicationUUID "lot-102" | quote }},
        quantity: 11,
        putAwayDate: "2023-11-03"
    }
}
