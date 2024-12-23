package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

ProductVariant: commonType.#CommonType & {
	Name:        "ProductVariant"
	Description: "The variants of a product"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		shopifyID: {
			Type:        tailordb.#TypeString
			Description: "Shopify product ID"
		}
		availableForSale: {
			Type:        tailordb.#TypeBool
			Description: "Is the product available for sale"
		}
		barcode: {
			Type:        tailordb.#TypeString
			Description: "The barcode of the product"
		}
		sku: {
			Type:        tailordb.#TypeString
			Description: "The sku(Stock Keeping Unit) of the product"
		}
		displayName: {
			Type:        tailordb.#TypeString
			Description: "The display name of the product"
		}
		imageID: {
			Type:        tailordb.#TypeUUID
			Description: "The image of the product variant"
		}
		image: {
			Type:        "ProductImage"
			Description: "The image of the product variant"
			SourceId:    "imageID"
		}
		inventoryQuantity: {
			Type:        tailordb.#TypeInt
			Description: "The inventory quantity of the product"
		}
		price: {
			Type:        tailordb.#TypeFloat
			Description: "The price of the product"
		}
		inventoryItemID: {// hashed shopify id
			Type:        tailordb.#TypeUUID
			Description: "The inventory item ID of the product deprecated"
		}
		inventoryItem: {
			Type:        "InventoryItem"
			Description: "The inventory item of the product"
			SourceId:    "inventoryItemID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "The product ID of the product variant"
		}
		product: {
			Type:        "Product"
			Description: "The product of the product variant"
			SourceId:    "productID"
		}
		taxable: {
			Type:        tailordb.#TypeBool
			Description: "Is the product taxable"
		}
		inventoryType: {
			Type:        tailordb.#TypeEnum
			Description: "inventoryType"
			AllowedValues: [
				{Value: "INVENTORY", Description: "INVENTORY item"},
				{Value: "NONINVENTORY", Description: "NONINVENTORY item"},
			]
			Hooks: {
				CreateExpr: "_value == null ? 'INVENTORY' : _value"
			}
		}
		quickbookItemId: {
			Type:        tailordb.#TypeString
			Description: "The quickbook item ID of the product"
		}
		quickbookSyncToken: {
			Type:        tailordb.#TypeString
			Description: "The quickbook sync token of the product"
		}
		quickbookItemName: {
			Type:        tailordb.#TypeString
			Description: "The quickbook item name of the product"
		}
	}
	TypePermission: permissions.editorAccess
}
