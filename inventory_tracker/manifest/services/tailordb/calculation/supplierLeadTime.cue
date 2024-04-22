package calculation

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

SupplierLeadTime: tailordb.#Type & {
	Name:        "SupplierLeadTime"
	Description: "Supplier lead time"
	Settings: {
		Aggregation: true
	}
	Fields: {
		product: {
			Type:        "Product"
			Description: "Product model"
			SourceId:    "productID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
			Required:    true
		}
		location: {
			Type:        "Location"
			Description: "Location model"
			SourceId:    "locationID"
		}
		locationID: {
			Type:        tailordb.#TypeUUID
			Description: "Location ID"
			Required:    true
		}
		supplier: {
			Type:        "Supplier"
			Description: "Supplier model"
			SourceId:    "supplierID"
		}
		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "Supplier ID"
			Required:    true
		}
		averageLeadTime: {
			Type:        tailordb.#TypeFloat
			Description: "Lead time"
			Required:    false
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}