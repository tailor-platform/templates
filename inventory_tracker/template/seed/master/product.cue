package product

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
	for k, v in _products {
		{
			query: _query
			variables: {
				id:       v.id
				code:     v.code
				name:     v.name
				description: v.description
				price: v.price
				uom: v.uom
				sellingStartDate: v.sellingStartDate
			}
		}
	},
]

_query: """
mutation (
	$id: ID,
	$code: Int,
	$name: String,
	$description: String,
	$price: Float,
	$uom: String,
	$sellingStartDate: Date,
) {
Product1: createProduct(
	input: {
		id: $id
		code: $code
		name: $name
		description: $description
		price: $price
		uom: $uom
		sellingStartDate: $sellingStartDate
	}
) {
	id
}
}"""

_products: {
    Product1: {
        id: {{ generateApplicationUUID "product-1" | quote }},
        code: 3001,
        name: "Organic Cotton T-Shirt",
        description: "Soft, breathable, and made from 100% organic cotton",
        price: 25,
        uom: "piece",
        sellingStartDate: "2023-11-01"
    },
    Product2: {
        id: {{ generateApplicationUUID "product-2" | quote }},
        code: 3002,
        name: "Eco-Friendly Denim Jeans",
        description: "Stylish, durable jeans made from sustainably sourced denim",
        price: 75,
        uom: "pair",
        sellingStartDate: "2023-11-02"
    },
    Product3: {
        id: {{ generateApplicationUUID "product-3" | quote }},
        code: 3003,
        name: "Bamboo Fiber Socks",
        description: "Comfortable, antibacterial socks made from bamboo fibers",
        price: 15,
        uom: "pair",
        sellingStartDate: "2023-11-03"
    },
    Product4: {
        id: {{ generateApplicationUUID "product-4" | quote }},
        code: 3004,
        name: "Recycled Polyester Jacket",
        description: "Warm, lightweight jacket made from recycled polyester",
        price: 120,
        uom: "piece",
        sellingStartDate: "2023-11-04"
    },
    Product5: {
        id: {{ generateApplicationUUID "product-5" | quote }},
        code: 3005,
        name: "Silk Scarf",
        description: "Luxurious, handcrafted scarf made from pure silk",
        price: 50,
        uom: "piece",
        sellingStartDate: "2023-11-05"
    }
}
