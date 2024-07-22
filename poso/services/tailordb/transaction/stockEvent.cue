package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

StockEvent: tailordb.#Type & {
	Name:        "StockEvent"
	Description: "StockEvent model"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
			Required:    true
		}
		product: {
			Type:        "Product"
			Description: "Product model. Line Item and Product is n:1."
			SourceId:    "productID"
		}
		unitCost: {
			Type:        tailordb.#TypeFloat
			Description: "Unit cost of the product"
			Required:    true
		}
		incrementalQuantity: {
			Type:        tailordb.#TypeInt
			Description: "delta of quantity. This value will be negative value if the event reduces inventory quantities"
			Required:    true
		}
		documentID: {
			Type:        tailordb.#TypeUUID
			Description: "Document ID"
		}
		document: {
			Type:        "Document"
			Description: "Document model. Line Item and Document is n:1."
			SourceId:    "documentID"
		}
		transactionTotalCost: {
			Type:        tailordb.#TypeFloat
			Description: "Amount of the transaction"
			Hooks: {
				CreateExpr: """
						decimal(_value.unitCost) * decimal(_value.incrementalQuantity)
					"""
				UpdateExpr: CreateExpr
			}
		}
		totalQuantity: {
			Type:        tailordb.#TypeInt
			Description: "DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Total quantity of the product at the time of the event"
		}
		totalCost: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Total cost of the product at the time of the event"
		}
		averageCost: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event"
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

	TypePermission: permissions.editorAccess
}
