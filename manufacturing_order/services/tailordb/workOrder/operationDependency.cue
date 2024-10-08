package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

OperationDependency: tailordb.#Type & {
	Name:        "OperationDependency"
	Description: "To know the dependency of operation"
	Settings: {
		BulkUpsert:  true
	}
	Indexes: {
		operationDependenciesCompositeKey: {
			FieldNames: ["operationId", "dependsOnOperationId"]
			Unique: true
		}
	}
	Fields: {
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
		dependsOnOperationId: {
			Type:        tailordb.#TypeUUID
			Description: "Depends On OperationId description"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "Operation"
		}
		dependsOnOperation: {
			Type:        "Operation"
			Description: "Depends On OperationId description"
			SourceId:    "dependsOnOperationId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
