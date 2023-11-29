package stockEvent

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
	for k, v in _stockEvents {
		{
			query: _query
			variables: {
				id: v.id
				lotID: v.lotID
				incrementalQuantity: v.incrementalQuantity
				eventDate: v.eventDate
                reason: v.reason
			}
		}
	},
]

_query: """
mutation (
    $id: ID,
    $eventDate: Date!,
    $lotID: ID!,
    $incrementalQuantity: Int!,
    $reason: String!,
    ) {
        stockEvent1: createStockEvent(
            input: {
                id: $id
                eventDate:$eventDate
                lotID: $lotID
                incrementalQuantity: $incrementalQuantity
                reason: $reason
            }
        ) {
            id
        }
    }"""

_stockEvents: {
    StockEvent1: {
        id: {{ generateApplicationUUID "stockEvent-1" | quote }},
        eventDate: "2023-11-02",
        lotID: {{ generateApplicationUUID "lot-1" | quote }},
        incrementalQuantity: 8,
        reason: "Put Away"
    },
    StockEvent2: {
        id: {{ generateApplicationUUID "stockEvent-2" | quote }},
        eventDate: "2023-11-03",
        lotID: {{ generateApplicationUUID "lot-2" | quote }},
        incrementalQuantity: 19,
        reason: "Put Away"
    },
    StockEvent3: {
        id: {{ generateApplicationUUID "stockEvent-3" | quote }},
        eventDate: "2023-11-05",
        lotID: {{ generateApplicationUUID "lot-3" | quote }},
        incrementalQuantity: 3,
        reason: "Put Away"
    },
    StockEvent4: {
        id: {{ generateApplicationUUID "stockEvent-4" | quote }},
        eventDate: "2023-11-06",
        lotID: {{ generateApplicationUUID "lot-4" | quote }},
        incrementalQuantity: 7,
        reason: "Put Away"
    },
    StockEvent5: {
        id: {{ generateApplicationUUID "stockEvent-5" | quote }},
        eventDate: "2023-11-06",
        lotID: {{ generateApplicationUUID "lot-5" | quote }},
        incrementalQuantity: 1,
        reason: "Put Away"
    },
    StockEvent6: {
        id: {{ generateApplicationUUID "stockEvent-6" | quote }},
        eventDate: "2023-11-06",
        lotID: {{ generateApplicationUUID "lot-6" | quote }},
        incrementalQuantity: 1,
        reason: "Put Away"
    },
    StockEvent7: {
        id: {{ generateApplicationUUID "stockEvent-7" | quote }},
        eventDate: "2023-11-06",
        lotID: {{ generateApplicationUUID "lot-7" | quote }},
        incrementalQuantity: 11,
        reason: "Put Away"
    },
    StockEvent8: {
        id: {{ generateApplicationUUID "stockEvent-8" | quote }},
        eventDate: "2023-11-07",
        lotID: {{ generateApplicationUUID "lot-8" | quote }},
        incrementalQuantity: 7,
        reason: "Put Away"
    },
    StockEvent9: {
        id: {{ generateApplicationUUID "stockEvent-9" | quote }},
        eventDate: "2023-11-07",
        lotID: {{ generateApplicationUUID "lot-9" | quote }},
        incrementalQuantity: 7,
        reason: "Put Away"
    },
    StockEvent10: {
        id: {{ generateApplicationUUID "stockEvent-10" | quote }},
        eventDate: "2023-11-07",
        lotID: {{ generateApplicationUUID "lot-10" | quote }},
        incrementalQuantity: 10,
        reason: "Put Away"
    },
    StockEvent11: {
        id: {{ generateApplicationUUID "stockEvent-11" | quote }},
        eventDate: "2023-11-07",
        lotID: {{ generateApplicationUUID "lot-11" | quote }},
        incrementalQuantity: 2,
        reason: "Put Away"
    },
    StockEvent12: {
        id: {{ generateApplicationUUID "stockEvent-12" | quote }},
        eventDate: "2023-11-08",
        lotID: {{ generateApplicationUUID "lot-12" | quote }},
        incrementalQuantity: 20,
        reason: "Put Away"
    },
    StockEvent13: {
        id: {{ generateApplicationUUID "stockEvent-13" | quote }},
        eventDate: "2023-11-09",
        lotID: {{ generateApplicationUUID "lot-13" | quote }},
        incrementalQuantity: 50,
        reason: "Put Away"
    },
    StockEvent14: {
        id: {{ generateApplicationUUID "stockEvent-14" | quote }},
        eventDate: "2023-11-09",
        lotID: {{ generateApplicationUUID "lot-14" | quote }},
        incrementalQuantity: 7,
        reason: "Put Away"
    },
    StockEvent15: {
        id: {{ generateApplicationUUID "stockEvent-15" | quote }},
        eventDate: "2023-11-10",
        lotID: {{ generateApplicationUUID "lot-15" | quote }},
        incrementalQuantity: 3,
        reason: "Put Away"
    },
    StockEvent16: {
        id: {{ generateApplicationUUID "stockEvent-16" | quote }},
        eventDate: "2023-11-11",
        lotID: {{ generateApplicationUUID "lot-16" | quote }},
        incrementalQuantity: 2,
        reason: "Put Away"
    },
    StockEvent17: {
        id: {{ generateApplicationUUID "stockEvent-17" | quote }},
        eventDate: "2023-11-11",
        lotID: {{ generateApplicationUUID "lot-17" | quote }},
        incrementalQuantity: 3,
        reason: "Put Away"
    },
    StockEvent18: {
        id: {{ generateApplicationUUID "stockEvent-18" | quote }},
        eventDate: "2023-11-12",
        lotID: {{ generateApplicationUUID "lot-18" | quote }},
        incrementalQuantity: 40,
        reason: "Put Away"
    },
    StockEvent19: {
        id: {{ generateApplicationUUID "stockEvent-19" | quote }},
        eventDate: "2023-11-14",
        lotID: {{ generateApplicationUUID "lot-19" | quote }},
        incrementalQuantity: 10,
        reason: "Put Away"
    },
    StockEvent20: {
        id: {{ generateApplicationUUID "stockEvent-20" | quote }},
        eventDate: "2023-11-17",
        lotID: {{ generateApplicationUUID "lot-20" | quote }},
        incrementalQuantity: 2,
        reason: "Put Away"
    },
    StockEvent21: {
        id: {{ generateApplicationUUID "stockEvent-21" | quote }},
        eventDate: "2023-11-11",
        lotID: {{ generateApplicationUUID "lot-1" | quote }},
        incrementalQuantity: -5,
        reason: "Ship Out"
    },
    StockEvent22: {
        id: {{ generateApplicationUUID "stockEvent-22" | quote }},
        eventDate: "2023-11-11",
        lotID: {{ generateApplicationUUID "lot-2" | quote }},
        incrementalQuantity: -10,
        reason: "Ship Out"
    },
    StockEvent23: {
        id: {{ generateApplicationUUID "stockEvent-23" | quote }},
        eventDate: "2023-11-12",
        lotID: {{ generateApplicationUUID "lot-3" | quote }},
        incrementalQuantity: -2,
        reason: "Ship Out"
    },
    StockEvent24: {
        id: {{ generateApplicationUUID "stockEvent-24" | quote }},
        eventDate: "2023-11-13",
        lotID: {{ generateApplicationUUID "lot-4" | quote }},
        incrementalQuantity: -5,
        reason: "Ship Out"
    },
    StockEvent25: {
        id: {{ generateApplicationUUID "stockEvent-25" | quote }},
        eventDate: "2023-11-14",
        lotID: {{ generateApplicationUUID "lot-5" | quote }},
        incrementalQuantity: -1,
        reason: "Ship Out"
    },
    StockEvent26: {
        id: {{ generateApplicationUUID "stockEvent-26" | quote }},
        eventDate: "2023-11-15",
        lotID: {{ generateApplicationUUID "lot-6" | quote }},
        incrementalQuantity: -1,
        reason: "Ship Out"
    },
    StockEvent27: {
        id: {{ generateApplicationUUID "stockEvent-27" | quote }},
        eventDate: "2023-11-16",
        lotID: {{ generateApplicationUUID "lot-7" | quote }},
        incrementalQuantity: -10,
        reason: "Ship Out"
    },
    StockEvent28: {
        id: {{ generateApplicationUUID "stockEvent-28" | quote }},
        eventDate: "2023-11-17",
        lotID: {{ generateApplicationUUID "lot-8" | quote }},
        incrementalQuantity: -3,
        reason: "Ship Out"
    },
    StockEvent29: {
        id: {{ generateApplicationUUID "stockEvent-29" | quote }},
        eventDate: "2023-11-18",
        lotID: {{ generateApplicationUUID "lot-9" | quote }},
        incrementalQuantity: -3,
        reason: "Ship Out"
    },
    StockEvent30: {
        id: {{ generateApplicationUUID "stockEvent-30" | quote }},
        eventDate: "2023-11-19",
        lotID: {{ generateApplicationUUID "lot-10" | quote }},
        incrementalQuantity: -5,
        reason: "Ship Out"
    }
}
