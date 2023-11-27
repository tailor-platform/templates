package putAway

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
    ) {
        putAway1: createPutAway(
            input: {
                id: $id
                purchaseOrderID: $purchaseOrderID
                quantity: $quantity
                putAwayDate:$putAwayDate
            }
        ) {
            id
        }
    }"""

_putAways: {
    PutAway1: {
        id: {{ generateApplicationUUID "putAway-1" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-4" | quote }},
        quantity: 8,
        putAwayDate: "2023-11-02"
    },
    PutAway2: {
        id: {{ generateApplicationUUID "putAway-2" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-3" | quote }},
        quantity: 19,
        putAwayDate: "2023-11-03"
    },
    PutAway3: {
        id: {{ generateApplicationUUID "putAway-3" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-1" | quote }},
        quantity: 3,
        putAwayDate: "2023-11-05"
    },
    PutAway4: {
        id: {{ generateApplicationUUID "putAway-4" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-1" | quote }},
        quantity: 7,
        putAwayDate: "2023-11-06"
    },
    PutAway5: {
        id: {{ generateApplicationUUID "putAway-5" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-3" | quote }},
        quantity: 1,
        putAwayDate: "2023-11-06"
    },
    PutAway6: {
        id: {{ generateApplicationUUID "putAway-6" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-4" | quote }},
        quantity: 1,
        putAwayDate: "2023-11-06"
    },
    PutAway7: {
        id: {{ generateApplicationUUID "putAway-7" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-5" | quote }},
        quantity: 11,
        putAwayDate: "2023-11-06"
    },
    PutAway8: {
        id: {{ generateApplicationUUID "putAway-8" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-5" | quote }},
        quantity: 7,
        putAwayDate: "2023-11-07"
    },
    PutAway9: {
        id: {{ generateApplicationUUID "putAway-9" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-2" | quote }},
        quantity: 7,
        putAwayDate: "2023-11-07"
    },
    PutAway10: {
        id: {{ generateApplicationUUID "putAway-10" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-8" | quote }},
        quantity: 10,
        putAwayDate: "2023-11-07"
    },
    PutAway11: {
        id: {{ generateApplicationUUID "putAway-11" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-10" | quote }},
        quantity: 2,
        putAwayDate: "2023-11-07"
    },
    PutAway12: {
        id: {{ generateApplicationUUID "putAway-12" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-6" | quote }},
        quantity: 20,
        putAwayDate: "2023-11-08"
    },
    PutAway13: {
        id: {{ generateApplicationUUID "putAway-13" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-6" | quote }},
        quantity: 50,
        putAwayDate: "2023-11-09"
    },
    PutAway14: {
        id: {{ generateApplicationUUID "putAway-14" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-11" | quote }},
        quantity: 7,
        putAwayDate: "2023-11-09"
    },
    PutAway15: {
        id: {{ generateApplicationUUID "putAway-15" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-2" | quote }},
        quantity: 3,
        putAwayDate: "2023-11-10"
    },
    PutAway16: {
        id: {{ generateApplicationUUID "putAway-16" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-8" | quote }},
        quantity: 2,
        putAwayDate: "2023-11-11"
    },
    PutAway17: {
        id: {{ generateApplicationUUID "putAway-17" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-7" | quote }},
        quantity: 3,
        putAwayDate: "2023-11-11"
    },
    PutAway18: {
        id: {{ generateApplicationUUID "putAway-18" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-9" | quote }},
        quantity: 40,
        putAwayDate: "2023-11-12"
    },
    PutAway19: {
        id: {{ generateApplicationUUID "putAway-19" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-9" | quote }},
        quantity: 10,
        putAwayDate: "2023-11-14"
    },
    PutAway20: {
        id: {{ generateApplicationUUID "putAway-20" | quote }},
        purchaseOrderID: {{ generateApplicationUUID "purchaseOrder-11" | quote }},
        quantity: 2,
        putAwayDate: "2023-11-17"
    }
}
