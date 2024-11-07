package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

ManufacturingOrder: tailordb.#Type & {
	Name: "ManufacturingOrder"
	Description: "ManufacturingOrder"
	Fields: {
		itemId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated item"
			ForeignKey:  true
			ForeignKeyType: "Item"
		}
		item: {
			Type:        "Item"
			Description: "Link to the Item"
			SourceId:    "itemId"
		}
		bomId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated BOM"
			ForeignKey:  true
			ForeignKeyType: "Bom"
		}
		bom: {
			Type:        "Bom"
			Description: "Link to the BOM"
			SourceId:    "bomId"
		}
		name: {
			Type: tailordb.#TypeString
			Description:  "Name of the Manufacturing Order"
		}
		startDateTime: {
			Type: tailordb.#TypeDateTime
			Description:  "Date of scheduling and time"
		}
		endDateTime: {
			Type: tailordb.#TypeDateTime
			Description:  "Date of scheduling and time"
		}
		componentsStatus: {
			Type: tailordb.#TypeString
			Description:  "Status of components for manufacturing"
			AllowedValues: [
				{Value: "Ready", Description: "Ready"},
				{Value: "Pending", Description: "Pending"},
				{Value: "In_Progress", Description: "In Progress"},
				{Value: "Blocked", Description: "Blocked"},
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 'Ready'
				"""
			}
		}
		quantity: {
			Type: tailordb.#TypeFloat
			Description:  "Quantity to be produced"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 1
				"""
			}
		}
		status: {
			Type: tailordb.#TypeEnum
			Description:  "Current status of manufacturing order"
			AllowedValues: [
				{Value: "Draft", Description: "Draft"},
				{Value: "Placed", Description: "Placed"},
				{Value: "In_Progress", Description: "In Progress"},
				{Value: "Pending", Description: "Pending"},
				{Value: "Completed", Description: "Completed"},
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 'Draft'
				"""
			}
		}
		totalCost: {
			Type: tailordb.#TypeString
			Description:  "Total cost of manufacturing"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		bomCost: {
			Type: tailordb.#TypeString
			Description:  "BOM cost for this order"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		woCost: {
			Type: tailordb.#TypeString
			Description:  "Work Order cost"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		parentMoId: {
			Type: tailordb.#TypeString
			Description:  "Parent Manufacturing Order ID"
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
		isPlanCreated: {
			Type:        tailordb.#TypeBool
			Description: "isPlanCreated description"
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