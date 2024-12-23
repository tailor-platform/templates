package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

WorkOrderTransition: tailordb.#Type & {
	Name:        "WorkOrderTransition"
	Description: "Status tracking of work order"
	Settings: {
		BulkUpsert:  true
	}
	Fields: {
		workOrderId: {
			Type:        tailordb.#TypeUUID
			Description: "ID of the WorkOrder"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "WorkOrder"
		}
		workOrder: {
			Type:        "WorkOrder"
			Description: "Link to the WorkOrder"
			SourceId:    "workOrderId"
		}
		fromStatus: {
			Type:        tailordb.#TypeEnum
			Description: "from status description"
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
		toStatus: {
			Type:        tailordb.#TypeEnum
			Description: "to status description"
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
		timeInStatus: {
			Type:        tailordb.#TypeInt
			Description: "Minutes in particular status"
			Required:   true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
