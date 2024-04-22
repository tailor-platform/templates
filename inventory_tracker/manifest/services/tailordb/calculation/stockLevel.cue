package calculation

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

StockLevel: tailordb.#Type & {
	Name:        "StockLevel"
	Description: "Stock level"
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
		sumOfIncrementalQuantity: {
			Type:        tailordb.#TypeInt
			Description: "Sum of incremental quantity."
			Required:    true
		}
		dailyDemand: {
			Type:        tailordb.#TypeFloat
			Description: "Daily demand."
		}
		daysToStockout: {
			Type:        tailordb.#TypeFloat
			Description: "Days to stock out."
			Hooks:   {
				CreateExpr: "decimal(_value.sumOfIncrementalQuantity) / decimal(_value.dailyDemand)"
				UpdateExpr: "decimal(_value.sumOfIncrementalQuantity) / decimal(_value.dailyDemand)"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}