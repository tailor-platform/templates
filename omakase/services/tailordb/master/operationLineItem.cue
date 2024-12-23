package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

OperationLineItem : tailordb.#Type & {
	Name:        "OperationLineItem"
	Description: "Represents a line item in an operation"
	Settings: {
		BulkUpsert: true
	}
	
	Fields: {
		bomId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated BOM"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Bom"
		}
		bom: {
			Type:        "Bom"
			Description: "Link to the BOM"
			SourceId:    "bomId"
		}
		operationId: {
			Type:           tailordb.#TypeUUID
			Description:    "Unique identifier of the associated Operation"
			Required:       true
			ForeignKey:     true
			ForeignKeyType: "Operation"
		}
		operation: {
			Type:        "Operation"
			Description: "Link to the Operation"
			SourceId:    "operationId"
		}
		bomLineItemId: {
			Type:           tailordb.#TypeUUID
			Description:    "Unique identifier of the associated Item"
			Required:       true
			ForeignKey:     true
			ForeignKeyType: "BomLineItem"
		}
		bomLineItem: {
			Type:        "BomLineItem"
			Description: "Link to the Item"
			SourceId:    "itemId"
		}
		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity"
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
			Type:           tailordb.#TypeUUID
			Description:    "Unique identifier of the associated Item for returning as new SKU"
			Required:       false
			ForeignKey:     true
			ForeignKeyType: "Item"
		}
		returnAsNewSkuItem: {
			Type:        "Item"
			Description: "Link to the Item to return as new SKU"
			SourceId:    "returnAsNewSkuItemId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
