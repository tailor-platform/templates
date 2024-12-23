package bom

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Item: tailordb.#Type & {
	Name:        "Item"
	Description: "Item description"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the item"
			Required:    true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Detailed description of the item"
		}
		sku: {
			Type:        tailordb.#TypeString
			Description: "Name of the SKU "
			Required:    true
		}
		isFinalProduct: {
			Type:        tailordb.#TypeBool
			Description: "Indicates if this is the final product"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : false
				"""
			}
		}
		inventoryType: {
			Type:        tailordb.#TypeEnum
			Description: "Type of inventory"
			AllowedValues: [
				{ Value: "INVENTORY", Description: "Item is counted as part of the inventory." },
				{ Value: "NON_INVENTORY", Description: "Item is not counted as part of the inventory. But is a product needed for the business." },
				{ Value: "SERVICE", Description: "Item is not counted as part of the inventory. And is a service." }
			]
			Required: true
		}
		uomId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the unit of measure"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Uom"
		}
		uom: {
			Type:        "Uom"
			Description: "Link to the Unit of Measure"
			SourceId:    "uomId"
		}
		bomId: {
			Type: tailordb.#TypeUUID
			Description: "ID of the BOM that is currently being used for this item"
			ForeignKey: true
			ForeignKeyType: "Bom"
		}
		bom: {
			Type:        "Bom"
			Description: "Link to the BOM"
			SourceId:    "bomId"
		}
		isActive: {
			Type:        tailordb.#TypeBool
			Description: "Indicates if the item is active"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : true
				"""
			}
		}
		quantity: {
			Type: tailordb.#TypeInt
			Description:  "quantity"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		woAllocatedQuantity: {
			Type: tailordb.#TypeInt
			Description:  "woAllocatedQuantity"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		wastedQuantity: {
			Type: tailordb.#TypeInt
			Description:  "wastedQuantity"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		scrapAction: {
			Type:        tailordb.#TypeEnum
			Description: "Scrap action for item"
			AllowedValues: [
				{ Value: "Return", Description: "Return" },
				{ Value: "Waste", Description: "Waste" },
				{ Value: "Return_as_new_SKU", Description: "Return as new SKU" }
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 'Return'
				"""
			}
		}
		returnAsNewSkuItemId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated item"
			Required:    false
			ForeignKey:  true
			ForeignKeyType: "Item"
		}
		returnAsNewSkuItem: {
			Type:        "Item"
			Description: "Link to the Item"
			SourceId:    "returnAsNewSkuItemId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
