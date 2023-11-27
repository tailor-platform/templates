package lot

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
	for k, v in _lots {
		{
			query: _query
			variables: {
				id: v.id
				putAwayID: v.putAwayID
			}
		}
	},
]

_query: """
mutation (
    $id: ID,
    $putAwayID: ID!,
    ) {
        lot1: createLot(
            input: {
                id: $id
                putAwayID: $putAwayID
            }
        ) {
            id
        }
    }"""

_lots: {
    Lot1: {
        id: {{ generateApplicationUUID "lot-1" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-1" | quote }}
    },
    Lot2: {
        id: {{ generateApplicationUUID "lot-2" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-2" | quote }}
    },
    Lot3: {
        id: {{ generateApplicationUUID "lot-3" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-3" | quote }}
    },
    Lot4: {
        id: {{ generateApplicationUUID "lot-4" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-4" | quote }}
    },
    Lot5: {
        id: {{ generateApplicationUUID "lot-5" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-5" | quote }}
    },
    Lot6: {
        id: {{ generateApplicationUUID "lot-6" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-6" | quote }}
    },
    Lot7: {
        id: {{ generateApplicationUUID "lot-7" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-7" | quote }}
    },
    Lot8: {
        id: {{ generateApplicationUUID "lot-8" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-8" | quote }}
    },
    Lot9: {
        id: {{ generateApplicationUUID "lot-9" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-9" | quote }}
    },
    Lot10: {
        id: {{ generateApplicationUUID "lot-10" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-10" | quote }}
    },
    Lot11: {
        id: {{ generateApplicationUUID "lot-11" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-11" | quote }}
    },
    Lot12: {
        id: {{ generateApplicationUUID "lot-12" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-12" | quote }}
    },
    Lot13: {
        id: {{ generateApplicationUUID "lot-13" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-13" | quote }}
    },
    Lot14: {
        id: {{ generateApplicationUUID "lot-14" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-14" | quote }}
    },
    Lot15: {
        id: {{ generateApplicationUUID "lot-15" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-15" | quote }}
    },
    Lot16: {
        id: {{ generateApplicationUUID "lot-16" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-16" | quote }}
    },
    Lot17: {
        id: {{ generateApplicationUUID "lot-17" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-17" | quote }}
    },
    Lot18: {
        id: {{ generateApplicationUUID "lot-18" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-18" | quote }}
    },
    Lot19: {
        id: {{ generateApplicationUUID "lot-19" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-19" | quote }}
    },
    Lot20: {
        id: {{ generateApplicationUUID "lot-20" | quote }},
        putAwayID: {{ generateApplicationUUID "putAway-20" | quote }}
    }
}
