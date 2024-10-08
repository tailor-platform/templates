package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

WOTimeTracking: tailordb.#Type & {
	Name:        "WOTimeTracking"
	Description: "Time tracking by employee"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
		PublishRecordEvents: true
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
		employeeId: {
			Type:        tailordb.#TypeUUID
			Description: "ID of the Employee"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "Employee"
		}
		employee: {
			Type:        "Employee"
			Description: "Link to the Employee"
			SourceId:    "employeeId"
		}
		duration: {
			Type:        tailordb.#TypeInt
			Description: "Minutes worked"
			Required:   true
		}
		startDate: {
			Type:        tailordb.#TypeDateTime
			Description: "Start date"
			Required:   true
		}
		endDate: {
			Type:        tailordb.#TypeDateTime
			Description: "End date"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
