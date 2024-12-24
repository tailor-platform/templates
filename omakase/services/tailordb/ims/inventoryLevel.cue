package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

InventoryLevel: commonType.#CommonType & {
	Name:        "InventoryLevel"
	Description: "Inventory Level of an inventory item"
	Fields: {
		locationID: {
			Type:        tailordb.#TypeUUID
			Description: "Inventory Location ID"
		}
		location: {
			Type:        "Location"
			Description: "Inventory Location"
			SourceId:    "locationID"
		}
		inventoryItemID: {
			Type:        tailordb.#TypeUUID
			Description: "Inventory Item ID"
		}
		inventoryItem: {
			Type:        "InventoryItem"
			Description: "Inventory Item"
			SourceId:    "inventoryItemID"
		}
		available: {
			Type:        tailordb.#TypeInt
			Description: "Amount of the inventory item available"
		}
		committed: {
			Type:        tailordb.#TypeInt
			Description: "Amount of the inventory item reserved"
		}
		reserved: {
			Type:        tailordb.#TypeInt
			Description: "Amount of the inventory item reserved"
		}
		damaged: {
			Type:        tailordb.#TypeInt
			Description: "Amount of the inventory item damaged"
		}
		safetyStock: {
			Type:        tailordb.#TypeInt
			Description: "Amount of the inventory item safety stock"
		}
		qualityControl: {
			Type:        tailordb.#TypeInt
			Description: "Amount of the inventory item in quality control"
		}
		onHand: {
			Type:        tailordb.#TypeInt
			Description: "Amount of the inventory item on hand"
		}
		incoming: {
			Type:        tailordb.#TypeInt
			Description: "Amount of the inventory item incoming"
		}
	}
	TypePermission: permissions.editorAccess
}
