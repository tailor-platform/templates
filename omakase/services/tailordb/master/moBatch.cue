package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

MoBatch: tailordb.#Type & {
	Name: "MOBatch"
	Description: "MOBatch"
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
		status: {
			Type: tailordb.#TypeEnum
			Description:  "Status of components for manufacturing"
			AllowedValues: [
				{Value: "Draft", Description: "Draft"},
                {Value: "Planned", Description: "Planned"},
				{Value: "In_Progress", Description: "In Progress"},
				{Value: "Completed", Description: "Completed"},
				{Value: "Canceled", Description: "Canceled"},
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 'Draft'
				"""
			}
		}
		quantity: {
			Type: tailordb.#TypeInt
			Description:  "Quantity to be produced"
			Required: true
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 1
				"""
			}
		}
		batchSize: {
			Type: tailordb.#TypeInt
			Description:  "batchSize to be produced"
			Required: true
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 1
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
