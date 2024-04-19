package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

Product: tailordb.#Type & {
	Name:        "Product"
	Description: "Product model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the product."
		}
		unitCost: {
			Type:        tailordb.#TypeFloat
			Description: "Default unit cost of the product."
		}
		unitPrice: {
			Type:        tailordb.#TypeFloat
			Description: "Default unit price of the product."
		}
		uom: {
			Type:        tailordb.#TypeString
			Description: "Unit of measure of the product."
		}
		costCategory: {
			Type:		tailordb.#TypeString
			Description: "The category name of this product for cost calculation."
		}
		taxID: {
			Type:        tailordb.#TypeUUID
			Description: "Tax ID"
		}
		tax: {
			Type:        "Tax"
			Description: "Tax model"
			SourceId:    "taxID"
		}
		inventoryType: {
			Type:        tailordb.#TypeEnum
			AllowedValues: [
                {Value: "INVENTORY", Description:     "INVENTORY type"},
				{Value: "NON_INVENTORY", Description: "NON_INVENTORY type"},
				{Value: "SERVICE", Description:        "SERVICE type"}
            ]
			Description: """
			Products are categorized into three types: 
			Inventory Items (tracked in stock quantities), 
			Non-inventory Items (tracked by cost and profit margin without inventory counts), and 
			Service Items (offerings without a purchase cost or inventory tracking). 
			By default, products are classified as Inventory Items, indicating stock levels are monitored."""
			Required: true
		}
		recalculatedLineItem:{
			Type:		tailordb.#TypeBool
			Description: "Provide false as the input when you are updating the line item from the front end."
			Required: true
		}
		inactive:{
			Type:		tailordb.#TypeBool
			Description: "Field used to delete the record. Instead of deleting the record, we set this field to true. This is to keep the data integrity."
			Hooks: {
				CreateExpr: "false"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
