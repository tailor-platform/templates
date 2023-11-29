package supplier

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
	for k, v in _suppliers {
		{
			query: _query
			variables: {
				id:       v.id
				code:     v.code
				name:     v.name
				contactNumber: v.contactNumber
				email:    v.email
				address:  v.address
			}
		}
	},
]

_query: """
mutation (
	$id: ID,
	$code: Int,
	$name: String,
	$contactNumber: String,
	$email: String,
	$address: String,
	) {
		Supplier1: createSupplier(
			input: {
				id: $id
				code: $code
				name: $name
				contactNumber: $contactNumber
				email: $email
				address: $address
			}
		) {
			id
		}
	}"""

_suppliers: {
    Supplier1: {
        id: {{ generateApplicationUUID "supplier-1" | quote }},
        code: 1001,
        name: "GreenTech Solutions",
        contactNumber: "212-555-1234",
        email: "contact@greentech.com",
        address: "123 Main St, New York, NY 10001"
    },
    Supplier2: {
        id: {{ generateApplicationUUID "supplier-2" | quote }},
        code: 1002,
        name: "Atlas Industrial Supply",
        contactNumber: "212-555-2345",
        email: "info@atlasindustrial.com",
        address: "456 Broadway, New York, NY 10002"
    },
    Supplier3: {
        id: {{ generateApplicationUUID "supplier-3" | quote }},
        code: 1003,
        name: "Riverside Textiles",
        contactNumber: "212-555-3456",
        email: "sales@riversidetextiles.com",
        address: "789 Park Ave, New York, NY 10003"
    },
    Supplier4: {
        id: {{ generateApplicationUUID "supplier-4" | quote }},
        code: 1004,
        name: "Nova Electronics",
        contactNumber: "212-555-4567",
        email: "support@novaelectronics.com",
        address: "012 Lexington Ave, New York, NY 10004"
    },
    Supplier5: {
        id: {{ generateApplicationUUID "supplier-5" | quote }},
        code: 1005,
        name: "Prime Building Materials",
        contactNumber: "212-555-5678",
        email: "prime@buildingmaterials.com",
        address: "345 6th Ave, New York, NY 10005"
    }
}
