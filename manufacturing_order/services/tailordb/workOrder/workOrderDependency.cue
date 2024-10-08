package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

WorkOrderDependency: tailordb.#Type & {
	Name:        "WorkOrderDependency"
	Description: "To know the dependency of workOrder"
	Settings: {
		BulkUpsert:  true
	}
	Indexes: {
		workOrderDependenciesCompositeKey: {
			FieldNames: ["workOrderId", "dependsOnWorkOrderId"]
			Unique: true
		}
	}
	Fields: {
		workOrderId: {
			Type:        tailordb.#TypeUUID
			Description: "workOrderId description"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "WorkOrder"
		}
		workOrder: {
			Type:        "WorkOrder"
			Description: "Link to the WorkOrder"
			SourceId:    "workOrderId"
		}
		dependsOnWorkOrderId: {
			Type:        tailordb.#TypeUUID
			Description: "Depends On WorkOrderId description"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "WorkOrder"
		}
		dependsOnWorkOrder: {
			Type:        "WorkOrder"
			Description: "Depends On WorkOrderId description"
			SourceId:    "dependsOnWorkOrderId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
