package material

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
	for k, v in materials {
		{
			query: """
			mutation (
				$id: ID
				$ppu: Int
				$uom: String
				$category: String
				$sku: String!
				$lotNum: String!
				$length: Int!
				$quantity: Int
				) {
					createMaterial(
						input: {
							id: $id
							pricePerUnit: $ppu
							uom: $uom
							materialCategory: $category
							sku:$sku
							lotNum:$lotNum
							length: $length
							quantity: $quantity
						}
					) {
					id
				}
			}"""
			variables: {
				id:       v.id
				ppu:      v.ppu
				uom:      v.uom
				category: v.category
				sku:     v.sku
				lotNum:     v.lotNum
				length:   v.length
				quantity: v.quantity
			}
		}
	},
]

materials: {
	material1: {
		id:       {{ generateWorkspaceUUID "Material1" | quote }}
		sku:      "MR001"
		lotNum:   "ABC123"
		ppu:      12
		uom:      "inch"
		category: "Metal Rods"
		length:   7
		quantity: 1
	}
	material2: {
		id:       {{ generateWorkspaceUUID "Material2" | quote }}
		sku:      "MR001"
		lotNum:   "GHX334"
		uom:      "inch"
		category: "Metal Rods"
		ppu:      12
		length:   7
		quantity: 1
	}
}
