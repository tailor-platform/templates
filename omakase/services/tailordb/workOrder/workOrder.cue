package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

WorkOrder: tailordb.#Type & {
	Name:        "WorkOrder"
	Description: "The actual work order which is created based on the Bom requirement"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
		PublishRecordEvents: true
	}
	Fields: {
		status: {
			Type:        tailordb.#TypeEnum
			Description: "status description"
			AllowedValues: [
				{Value: "Draft", Description: "Draft"},
				{Value: "Waiting_for_another_WO", Description: "Waiting for another Work Order"},
				{Value: "Waiting_for_components", Description: "Waiting for components"},
				{Value: "Ready", Description: "Ready"},
				{Value: "In_Progress", Description: "In Progress"},
				{Value: "Finished", Description: "Finished"},
				{Value: "Canceled", Description: "Canceled"},
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 'Draft'
				"""
			}
		}
		operationId: {
			Type:        tailordb.#TypeUUID
			Description: "operationId description"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "Operation"
		}
		operation: {
			Type:        "Operation"
			Description: "Link to the Operation"
			SourceId:    "operationId"
		}
		moId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated ManufacturingOrder"
			ForeignKey:  true
			ForeignKeyType: "ManufacturingOrder"
		}
		mo: {
			Type:        "ManufacturingOrder"
			Description: "Link to the ManufacturingOrder"
			SourceId:    "moId"
		}
		expectedDuration: {
			Type:        tailordb.#TypeInt
			Description: "expectedDuration description"
			Required:   true
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		realDuration: {
			Type:        tailordb.#TypeInt
			Description: "realDuration description"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		order: {
			Type:        tailordb.#TypeInt
			Description: "sequence order description"
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
		isBlocked: {
			Type:        tailordb.#TypeBool
			Description: "isBlocked description"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : false
				"""
			}
		}
		startDate: {
			Type:        tailordb.#TypeDateTime
			Description: "startDate description"
		}
		endDate: {
			Type:        tailordb.#TypeDateTime
			Description: "endDate description"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
