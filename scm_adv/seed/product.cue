package product

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
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
		id:       {{ generateWorkspaceUUID "Product1" | quote }}
		ppu:      12.99
		ean:      "5012345678910"
		uom:      "pack"
		category: "Office Supplies"
		name:     "Ballpoint Pens"
		code:     1
	}
	product2: {
		id:      {{ generateWorkspaceUUID "Product2" | quote }}
		ppu:      24.99
		ean:      "6012345678911"
		uom:      "box"
		category: "Office Supplies"
		name:     "A4 Paper Reams"
		code:     2
	}
	product3: {
		id:       {{ generateWorkspaceUUID "Product3" | quote }}
		ppu:      45.00
		ean:      "7012345678912"
		uom:      "piece"
		category: "Office Equipment"
		name:     "Adjustable Office Chair"
		code:     3
	}
	product4: {
		id:       {{ generateWorkspaceUUID "Product4" | quote }}
		ppu:      8.50
		ean:      "8012345678913"
		uom:      "pack"
		category: "Office Supplies"
		name:     "Sticky Notes"
		code:     4
	}
	product5: {
		id:       {{ generateWorkspaceUUID "Product5" | quote }}
		ppu:      14.75
		ean:      "9012345678914"
		uom:      "set"
		category: "Office Supplies"
		name:     "Highlighters"
		code:     5
	}
}
