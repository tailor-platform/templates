package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

FinancialStockSummary: commonType.#CommonType & {
	Name:        "FinancialStockSummary"
	Description: "StockSummary model for the financial ledger"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		variantID: {
			Type:        tailordb.#TypeUUID
			Description: "Variant ID"
			Required:    true
		}
		variant: {
			Type:        "ProductVariant"
			Description: "Variant"
			SourceId:    "variantID"
		}
		onHoldQuantity: {
			Type:        tailordb.#TypeFloat
			Description: "onHoldQuantity"
			Required:    true
		}
		availableQuantity: {
			Type:        tailordb.#TypeFloat
			Description: "availableQuantity"
			Required:    true
		}
		inStockQuantity: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END. The quantity of the product in stock."
			Hooks: {
				CreateExpr: """
						decimal(_value.onHoldQuantity) + decimal(_value.availableQuantity)
					"""
				UpdateExpr: CreateExpr
			}
		}
		totalCost: {
			Type:        tailordb.#TypeFloat
			Description: "totalCost"
			Required:    true
		}
		averageCost: {
			Type:        tailordb.#TypeFloat
			Description: "averageCost"
			Hooks: {
				CreateExpr: """
						(decimal(_value.onHoldQuantity) + decimal(_value.availableQuantity)) != decimal(0.0) ? 
						decimal(_value.totalCost) / (decimal(_value.onHoldQuantity) + decimal(_value.availableQuantity)) : 
						decimal(0.0)
					"""
				UpdateExpr: CreateExpr
			}
		}
	}
	TypePermission: permissions.adminAccess
}
