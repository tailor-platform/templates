package resolvers

import (
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)


// cutMaterialInput: {
// 	name: "cutMaterialInput"
//     fields: [ 
// 		{ name: "id", type: schema.ID, required: true },
// 		{ name: "cutLength", type: schema.Float, required: true },
// 		{ name: "isScrap", type: schema.ID},
// 	]
//   }

// cutMaterialResult: {
// 	name: "cutMaterialResult"
//     fields: [ 
// 		{ name: "productId", type: schema.ID},
// 		{ name: "materialId", type: schema.ID},
// 	]
//   }



cutMaterial: pipelinev1.#Resolver & {
	authorization: "true"
	id: "773fa5d1-4345-4eee-86e6-a171215af50b"
	name:        "cutMaterial"
	description: "cut a material and create a product"
	pipeline: [
		{
			id: "4942ef6d-8a39-4dd0-a53d-984f071d5b78"
			name:        "getMaterial"
			description: "get material data"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
			query ($id: ID!) {
				  material(id: $id) {
					id
					materialCode
					length
					pricePerUnit
					width
					materialName
					materialCategory
					uom
			  }
			}"""
			postScript: "args.material"
		},
		{
			id: "fe96ec9d-0bb6-458b-9086-01d54ee4f190"
			name:        "createProduct"
			description: "create a product"
			url:         settings.services.gateway
			preValidation: """
			context.pipeline.getMaterial.length > context.args.input.cutLength ? "" : "The length of the material is not sufficient to produce the desired product."
			"""
			preScript: """
			{
				"productCreateInput": compact({
					"productCode": "P-" + context.pipeline.getMaterial.materialCode,
					"length": context.args.input.cutLength,
					"pricePerUnit": context.pipeline.getMaterial.pricePerUnit,
					"uom": context.pipeline.getMaterial.uom,
					"productCategory": context.pipeline.getMaterial.materialCategory,
					"productName": "P-" + context.pipeline.getMaterial.materialName,
					"cutFromId": context.pipeline.getMaterial.id,
					"quantity": 1
				}),
				"materialId": context.pipeline.getMaterial.id,
				"materialUpdateInput": compact({
					"length": context.pipeline.getMaterial.length - context.args.input.cutLength,
					"isScrap": context.args.input.isScrap
				})
			}
			"""
			graphqlQuery: """
			mutation ($productCreateInput: ProductCreateInput, $materialId: ID!, $materialUpdateInput: MaterialUpdateInput) {
				  createProduct: createProduct(input: $productCreateInput) {
				    id
			  }
			  updateMaterial: updateMaterial(id: $materialId, input: $materialUpdateInput) {
				    id
			  }
			}"""
			postScript: """
			{
				"productId": args.createProduct.id,
				"materialId": args.updateMaterial.id
			}
			"""
		},
	]
}
