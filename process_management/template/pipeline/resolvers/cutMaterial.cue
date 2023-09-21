package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

cutMaterial: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "cutMaterial"
	description: "Cut the material and create a new product"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "getMaterial"
			description: "Get the material's data"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
			query ($id: ID!) {
				  material(id: $id) {
					id
					lotNum
					length
					pricePerUnit
					width
					sku
					materialCategory
					uom
					isScrap
			  }
			}"""
			postScript: "args.material"
			postValidation: """
			args.isScrap == false ? "" : "The material is already a scrap."
			"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "checkIfProductExists"
			description: "Check whether the product already exists"
			url:         settings.services.gateway
			preValidation: """
			context.pipeline.getMaterial.length >= context.args.input.cutLength ? "" : "The length of the material is not sufficient to produce the desired product."
			"""
			preScript: """
			{
				"lotNum": "P-" + context.pipeline.getMaterial.lotNum,
				"length": context.args.input.cutLength,
				"sku": "P-" + context.pipeline.getMaterial.sku
			}
			"""
			graphqlQuery: """
			query ($lotNum:String $sku:String $length:Int) {
				  products(query:{
				    lotNum:{eq:$lotNum}
					sku:{eq:$sku}
					length:{eq:$length}
			  }){
				    collection{
				      id
					  quantity
			    }
			  }
			}
			"""
			postScript: """
			{
				"productId": ifThen(args.products.collection == [], null, args.products.collection[0].id),
				"quantity": ifThen(args.products.collection == [], null, args.products.collection[0].quantity)
			}
			"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "createProduct"
			description: "Create a new product if there's no existing record"
			url:         settings.services.gateway
			test: "context.pipeline.checkIfProductExists.productId == null"
			preScript: """
			{
				"productCreateInput": compact({
					"lotNum": "P-" + context.pipeline.getMaterial.lotNum,
					"length": int(context.args.input.cutLength),
					"pricePerUnit": context.pipeline.getMaterial.pricePerUnit,
					"uom": context.pipeline.getMaterial.uom,
					"productCategory": context.pipeline.getMaterial.materialCategory,
					"sku": "P-" + context.pipeline.getMaterial.sku,
					"cutFromId": context.pipeline.getMaterial.id,
					"quantity": int(1)
				}),
				"materialId": context.pipeline.getMaterial.id,
				"materialUpdateInput": compact({
					"length": int(context.pipeline.getMaterial.length) - int(context.args.input.cutLength),
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
		{
			id: {{generateUUID | quote}}
			name:        "updateProduct"
			description: "Increment the quantity if the product already exists"
			url:         settings.services.gateway
			test: "context.pipeline.checkIfProductExists.productId != null"
			preScript: """
			{
				"productId": context.pipeline.checkIfProductExists.productId,
				"productUpdateInput": compact({
					"quantity": int(context.pipeline.checkIfProductExists.quantity) + 1
				}),
				"materialId": context.pipeline.getMaterial.id,
				"materialUpdateInput": compact({
					"length": int(context.pipeline.getMaterial.length) - int(context.args.input.cutLength),
					"isScrap": context.args.input.isScrap
				})
			}
			"""
			graphqlQuery: """
			mutation ($productId: ID!, $productUpdateInput: ProductUpdateInput, $materialId: ID!, $materialUpdateInput: MaterialUpdateInput) {
			  updateProduct: updateProduct(id: $productId, input: $productUpdateInput) {
			    id
			  }
			  updateMaterial: updateMaterial(id: $materialId, input: $materialUpdateInput) {
			    id
			  }
			}"""
			postScript: """
			{
				"productId": args.updateProduct.id,
				"materialId": args.updateMaterial.id
			}
			"""
		},
	]
}
