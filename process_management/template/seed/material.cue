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
				$ppu: Float
				$uom: String
				$category: String
				$name: String!
				$code: String!
				$length: Float!
				$quantity: Int
				) {
					createMaterial(
						input: {
							id: $id
							pricePerUnit: $ppu
							uom: $uom
							materialCategory: $category
							materialName: $name
							materialCode: $code
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
				name:     v.name
				code:     v.code
				length:   v.length
				quantity: v.quantity
			}
		}
	},
]

materials: {
	material1: {
		id:       {{ generateWorkspaceUUID "Material1" | quote }}
		name:     "SKU-A"
		code:     "001"
		ppu:      12.99
		uom:      "inch"
		category: "Metal Rods"
		length:   7.0
		quantity: 1
	}
	material2: {
		id:       {{ generateWorkspaceUUID "Material2" | quote }}
		name:     "SKU-A"
		code:     "001"
		uom:      "inch"
		category: "Metal Rods"
		ppu:      12.99
		length:   7.0
		quantity: 1
	}
}
