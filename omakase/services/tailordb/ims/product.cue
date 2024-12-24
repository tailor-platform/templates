package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

Product: commonType.#CommonType & {
	Name:        "Product"
	Description: "Product model"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		shopifyID: {
			Type:        tailordb.#TypeString
			Description: "Shopify product ID"
		}
		title: {
			Type:        tailordb.#TypeString
			Description: "Product title"
		}
		handle: {
			Type:        tailordb.#TypeString
			Description: "Product handle"
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Product description"
		}
		featuredImageID: {
			Type:        tailordb.#TypeUUID
			Description: "Featured image ID"
		}
		featuredImage: {
			Type:        "ProductImage"
			Description: "Featured image of the product"
			SourceId:    "featuredImageID"
		}
	}
	TypePermission: permissions.editorAccess
}
