package master

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
	}
	Fields: {
		status: {
			Type:        tailordb.#TypeEnum
			Description: "status description"
			AllowedValues: [
				{Value: "Waiting_for_another_WO", Description: "Waiting for another Work Order"},
				{Value: "Waiting_for_components", Description: "Waiting for components"},
				{Value: "Ready", Description: "Ready"},
				{Value: "In_Progress", Description: "In Progress"},
				{Value: "Finished", Description: "Finished"},
				{Value: "Blocked", Description: "Blocked"},
			]
			Required:   true
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
		workCenterId: {
			Type:        tailordb.#TypeUUID
			Description: "workCenterId description"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "WorkCenter"
		}
		workCenter: {
			Type:        "WorkCenter"
			Description: "Link to the WorkCenter"
			SourceId:    "workCenterId"
		}
		expectedDuration: {
			Type:        tailordb.#TypeInt
			Description: "expectedDuration description"
			Required:   true
		}
		realDuration: {
			Type:        tailordb.#TypeInt
			Description: "realDuration description"
			Hooks: {
				CreateExpr:  "0"
			}
		}
		isBlocked: {
			Type:        tailordb.#TypeBool
			Description: "isBlocked description"
			Hooks: {
				CreateExpr:  "false"
			}
		}
		isDeleted: {
			Type:        tailordb.#TypeBool
			Description: "isDeleted description"
			Hooks: {
				CreateExpr:  "false"
			}
		}
		startDate: {
			Type:        tailordb.#TypeDate
			Description: "startDate description"
		}
		endDate: {
			Type:        tailordb.#TypeDate
			Description: "endDate description"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
