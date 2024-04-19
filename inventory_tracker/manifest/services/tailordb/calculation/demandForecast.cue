package calculation

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

DemandForecast: tailordb.#Type & {
	Name:        "DemandForecast"
	Description: "Demand forecast"
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
		sellingStartDate: {
			Type:        tailordb.#TypeDate
			Description: "The date this product starts selling. This field is used to calculate the sales velocity used for demand forecasting."
		}
		today: {
			Type:        tailordb.#TypeDate
			Description: "The date of the calculation"
			Hooks:   {
				CreateExpr: "date(today())"
				UpdateExpr: "date(today())"
			}
		}
		dailyDemand: {
			Type:        tailordb.#TypeFloat
			Description: "Daily demand."
			Hooks:   {
				CreateExpr: "decimal(_value.sumOfIncrementalQuantity) / decimal((date(today()) - date(_value.sellingStartDate)).getHours()/24)"
				UpdateExpr: "decimal(_value.sumOfIncrementalQuantity) / decimal((date(today()) - date(_value.sellingStartDate)).getHours()/24)"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}