package calculation

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

StockHistory: tailordb.#Type & {
	Name:        "StockHistory"
	Description: "StockHistory model. Holds the rollback point for stock information of each product."
	Fields: {
		product: {
			Type:        "Product"
			Description: "Product model. Line Item and Product is n:1."
			SourceId:    "productID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
			Required:    true
		}
		totalQuantity: {
			Type:        tailordb.#TypeInt
			Description: "Total quantity of the product at the time of the event"
			Required:    true
		}
		totalCost: {
			Type:        tailordb.#TypeFloat
			Description: "Total cost of the product at the time of the event"
			Required:    true
		}
		averageCost: {
			Type:        tailordb.#TypeFloat
			Description: "Average cost of the product at the time of the event"
			Hooks: {
				CreateExpr: """
						_value.totalQuantity == 0 ? 0: decimal(_value.totalCost) / decimal(_value.totalQuantity)
					"""
				UpdateExpr: CreateExpr
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	Settings: {
		Aggregation: true
	}

	TypePermission: permissions.editorAccess
}
