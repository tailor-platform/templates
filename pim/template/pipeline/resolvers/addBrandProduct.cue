package resolvers

import (
	"tailor.build/pim/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	"encoding/json"
)

addBrandProduct: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "addBrandProduct"
	description: "creates a new brand user"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "createsProduct"
			description: "creates a new product"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
			mutation ($productName: String!, $productDescription: String!, $brandID: ID!) {
				createProduct(
				    input: {
				      productName: $productName
					  productDescription: $productDescription
					  brandID: $brandID
					}
				) {
					id
				}
			}"""
			postScript: """
			{
				"brandGroupPermissionList": user.groups.map(e,
					{
						"id": e,
						"permit": "allow"
					}
				),
				"id": args.createProduct.id
			}
			"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "changeProductPermission"
			description: "change product permission"
			url:         settings.services.gateway
			contextData: json.Marshal({settings.permissions})
			preScript: """
				     {
						"productID": context.pipeline.createsProduct.id,
						"read": context.data.read + context.pipeline.createsProduct.brandGroupPermissionList,
						"update": context.data.update + context.pipeline.createsProduct.brandGroupPermissionList,
						"delete": context.data.delete + context.pipeline.createsProduct.brandGroupPermissionList
				    }"""
			graphqlQuery: """
			mutation (
				$productID: ID!
				$read: [PermissionItemInput]
				$update: [PermissionItemInput]
				$delete: [PermissionItemInput]
				){
				  changeProduct(id: $productID, read: $read, update: $update, delete: $delete)
				}"""
			postScript: """
			{
				"id":context.pipeline.createsProduct.id
			}"""
		},
	]
}
