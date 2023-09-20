package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
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
	id: {{generateUUID | quote}}
	name:        "cutMaterial"
	description: "cut a material and create a product"
	pipeline: [
		{
			id: {{generateUUID | quote}}
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
			id: {{generateUUID | quote}}
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
