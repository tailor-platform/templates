package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

WorkOrderLineItem : tailordb.#Type & {
	Name:        "WorkOrderLineItem"
	Description: "Represents a line item in a work order"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		moId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated MO"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "ManufacturingOrder"
		}
		mo: {
			Type:        "ManufacturingOrder"
			Description: "Link to the MO"
			SourceId:    "moId"
		}
		workOrderId: {
			Type:           tailordb.#TypeUUID
			Description:    "Unique identifier of the associated WorkOrder"
			Required:       true
			ForeignKey:     true
			ForeignKeyType: "WorkOrder"
		}
		workOrder: {
			Type:        "WorkOrder"
			Description: "Link to the WorkOrder"
			SourceId:    "workOrderId"
		}
		moLineItemId: {
			Type:           tailordb.#TypeUUID
			Description:    "Unique identifier of the associated MOLineItem"
			Required:       true
			ForeignKey:     true
			ForeignKeyType: "MOLineItem"
		}
		moLineItem: {
			Type:        "MOLineItem"
			Description: "Link to the MOLineItem"
			SourceId:    "moLineItemId"
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
			Description:    "Unique identifier of the associated item"
			Required:       false
			ForeignKey:     true
			ForeignKeyType: "Item"
		}
		returnAsNewSkuItem: {
			Type:        "Item"
			Description: "Link to the Item"
			SourceId:    "returnAsNewSkuItemId"
		}
		isDeleted: {
			Type:        tailordb.#TypeBool
			Description: "isDeleted description"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : false
				"""
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
