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
	for k, v in products {
		{
			query: """
				     mutation (
				       $id: ID
				       $ppu: Float
				       $ean: String
				       $uom: String
				       $category: String
				       $name: String
				       $code: Int
				     ) {
				       product1: createProduct(
				         input: {
				           id: $id
				           pricePerUnit: $ppu
				           eanCode: $ean
				           uom: $uom
				           productCategory: $category
				           productName: $name
				           productCode: $code
				         }
				       ) {
				         id
				       }
				     }"""
			variables: {
				id:       v.id
				ppu:      v.ppu
				ean:      v.ean
				uom:      v.uom
				category: v.category
				name:     v.name
				code:     v.code
			}
		}
	},
]

products: {
	product1: {
		id:    {{ generateApplicationUUID "Product1" | quote }}
		ppu:      15.99
		ean:      "5012345678910"
		uom:      "pack"
		category: "Stationery"
		name:     "Premium Ballpoint Pens"
		code:     1
	}
	product2: {
		id:   {{ generateApplicationUUID "Product2" | quote }}
		ppu:      30.99
		ean:      "6012345678911"
		uom:      "box"
		category: "Office Supplies"
		name:     "Recycled A4 Paper Reams"
		code:     2
	}
	product3: {
		id:   {{ generateApplicationUUID "Product3" | quote }}
		ppu:      55.00
		ean:      "7012345678912"
		uom:      "piece"
		category: "Office Equipment"
		name:     "Ergonomic Office Chair"
		code:     3
	}
	product4: {
		id:   {{ generateApplicationUUID "Product4" | quote }}
		ppu:      10.50
		ean:      "8012345678913"
		uom:      "pack"
		category: "Stationery"
		name:     "Colorful Sticky Notes"
		code:     4
	}
	product5: {
		id:   {{ generateApplicationUUID "Product5" | quote }}
		ppu:      18.75
		ean:      "9012345678914"
		uom:      "set"
		category: "Stationery"
		name:     "Fluorescent Highlighters"
		code:     5
	}
}
