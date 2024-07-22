package calculation

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

ReplenishmentAlert: tailordb.#Type & {
	Name:        "ReplenishmentAlert"
	Description: "Replenishment alert"
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
		daysToStockout: {
			Type:        tailordb.#TypeFloat
			Description: "Days to stockout."
		}
		maxLeadTime: {
			Type:        tailordb.#TypeFloat
			Description: "Max lead time."
		}
		expectedDaysForNextOrder: {
			Type:        tailordb.#TypeFloat
			Description: "Expected days for next order."
			Hooks: {
				CreateExpr: "ifThen (_value.daysToStockout != null, _value.daysToStockout + _value.maxLeadTime)"
				UpdateExpr: "ifThen (_value.daysToStockout != null, _value.daysToStockout + _value.maxLeadTime)"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
