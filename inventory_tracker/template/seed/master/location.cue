package location

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
	for k, v in _locations {
		{
			query: _query
			variables: {
				id:       v.id
				code:     v.code
				name:     v.name
				address:  v.address
				type:     v.type
				contactNumber: v.contactNumber
			}
		}
	},
]

_query: """
mutation (
	$id: ID,
	$code: Int,
	$name: String,
	$address: String,
	$type: String,
	$contactNumber: String,
	) {
		Location1: createLocation(
			input: {
				id: $id
				code: $code
				name: $name
				address: $address
				type: $type
				contactNumber: $contactNumber
			}
			) {
				id
			}
	}"""

_locations: {
    Location1: {
        id: {{ generateApplicationUUID "location-1" | quote }},
        code: 2001,
        name: "Sunset Fabrics",
        address: "123 Sunset Blvd, Los Angeles, CA 90001",
        type: "storefront",
        contactNumber: "213-456-7890"
    },
    Location2: {
        id: {{ generateApplicationUUID "location-2" | quote }},
        code: 2002,
        name: "Starlight Textiles Warehouse",
        address: "456 Starlight Drive, San Francisco, CA 94101",
        type: "warehouse",
        contactNumber: "415-789-0123"
    },
    Location3: {
        id: {{ generateApplicationUUID "location-3" | quote }},
        code: 2003,
        name: "Oceanview Linens",
        address: "789 Oceanview Ave, San Diego, CA 92101",
        type: "storefront",
        contactNumber: "619-012-3456"
    },
    Location4: {
        id: {{ generateApplicationUUID "location-4" | quote }},
        code: 2004,
        name: "Golden Gate Garments Storage",
        address: "321 Golden Gate Ave, San Francisco, CA 94102",
        type: "warehouse",
        contactNumber: "415-234-5678"
    },
    Location5: {
        id: {{ generateApplicationUUID "location-5" | quote }},
        code: 2005,
        name: "Hollywood Threads",
        address: "654 Hollywood Blvd, Los Angeles, CA 90028",
        type: "storefront",
        contactNumber: "323-345-6789"
    },
    Location6: {
        id: {{ generateApplicationUUID "location-6" | quote }},
        code: 2006,
        name: "Pacific Textiles Logistics",
        address: "987 Pacific Highway, San Diego, CA 92102",
        type: "warehouse",
        contactNumber: "619-456-7890"
    }
}
