package product

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"{{ .Values.cue.package }}/charts/common:constant"
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
        $ppu: Int
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
      } """
			variables: {
        id: v.id
        ppu: v.ppu
        ean: v.ean
        uom: v.uom
        category: v.category
        name: v.name
        code: v.code
			}
		}
	},
]

products: {
	product1: {
		id:   constant.uuid & {_, #type: "product", #value: "1"}
    ppu: 10
    ean: "0123456789101"
    uom: "kg"
    category: "Material"
    name: "TEST1"
    code: 1
	}
	product2: {
		id:   constant.uuid & {_, #type: "product", #value: "2"}
    ppu: 20
    ean: "0123456789101"
    uom: "yd"
    category: "Material"
    name: "TEST2"
    code: 2
	}
	product3: {
		id:   constant.uuid & {_, #type: "product", #value: "3"}
    ppu: 30
    ean: "0123456789101"
    uom: "m"
    category: "Material"
    name: "TEST3"
    code: 3
	}
	product4: {
		id:   constant.uuid & {_, #type: "product", #value: "4"}
    ppu: 40
    ean: "0123456789101"
    uom: "kg"
    category: "Material"
    name: "TEST4"
    code: 4
	}
	product5: {
		id:   constant.uuid & {_, #type: "product", #value: "5"}
    ppu: 50
    ean: "0123456789101"
    uom: "mg"
    category: "Material"
    name: "TEST5"
    code: 5
	}
}



