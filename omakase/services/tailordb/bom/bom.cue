package bom

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Bom: tailordb.#Type & {
	Name:        "Bom"
	Description: "BOM description"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the BOM"
			Required:    true
			Index:       true
			Unique:      true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Detailed description of the BOM"
		}
		sku: {
			Type:        tailordb.#TypeString
			Description: "Name of the SKU"
			Required:    true
		}
		itemId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated item"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Item"
		}
		item: {
			Type:        "Item"
			Description: "Link to the Item"
			SourceId:    "itemId"
		}
		outputQuantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of the final product produced"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : decimal(1.0)
				"""
			}
		}
		bomType: {
			Type:        tailordb.#TypeEnum
			AllowedValues: [
				{ Value: "RECIPE", Description:     "The BOM is used to produce an item using a manufacturing or assembly process."},
				{ Value: "KIT", Description:     "The BOM is used to bundle multiple items together."},
				{ Value: "FINAL_PRODUCT", Description:   "The BOM represents the final product."},
				{ Value: "COMPONENT", Description:     "The BOM represents a component to build an item."}
			]
			Description: "Type or category of the BOM"
			Required:    true
		}
		isActive: {
			Type:        tailordb.#TypeBool
			Description: "Indicates if the BOM is active"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : true
				"""
			}
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
		isConfiguredProperly: {
			Type:        tailordb.#TypeBool
			Description: "Indicates bom lineitems and operations are linked properly or not"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : false
				"""
			}
		}
		configureMessage: {
			Type:        tailordb.#TypeString
			Description: "Indicates bom lineitems and operations are linked properly or not message"
			Required:    false
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
