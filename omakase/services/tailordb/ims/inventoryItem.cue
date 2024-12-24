package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

InventoryItem: commonType.#CommonType & {
	Name:        "InventoryItem"
	Description: "Product variant's inventory item model"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		shopifyID: {
			Type:        tailordb.#TypeString
			Description: "Shopify product ID"
		}
		productVariantID: {
			Type:        tailordb.#TypeUUID
			Description: "Product variant ID"
		}
		productVariant: {
			Type:        "ProductVariant"
			Description: "Product variant"
			SourceId:    "productVariantID"
		}
	}
	TypePermission: permissions.editorAccess
}
