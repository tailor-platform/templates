package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

ReceiptLineItem: commonType.#CommonType & {
	Name:        "ReceiptLineItem"
	Description: "ReceiptLineItem model"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		receiptID: {
			Type:        tailordb.#TypeUUID
			Description: "receipt ID"
			Required:    true
		}
		receipt: {
			Type:        "Receipt"
			Description: "Receipt model. Receipt and this model is n:1."
			SourceId:    "receiptID"
		}
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
		quantity: {
			Type:        tailordb.#TypeFloat
			Description: "quantity"
			Required:    true
		}
		subtotalUnitCost: {
			Type:        tailordb.#TypeFloat
			Description: "subtotalUnitCost"
			Required:    true
		}
		subtotalCost: {
			Type:        tailordb.#TypeFloat
			Description: "subtotalCost"
			Hooks: {
				CreateExpr: """
						decimal(_value.quantity) * decimal(_value.subtotalUnitCost)
					"""
				UpdateExpr: CreateExpr
			}
		}
		cubicMeters: {
			Type:        tailordb.#TypeFloat
			Description: "cubicMeters"
		}
		costPools: {
			Type:        tailordb.#TypeNested
			Description: "CostPool model. CostPool and this model is n:n."
			Array:       true
			Fields: {[string]: tailordb.#Field} & {
				costPoolID: {
					Type:        tailordb.#TypeUUID
					Description: "CostPool ID"
				}
				costPool: {
					Type:        "CostPool"
					Description: "CostPool model. CostPool and this model is n:n."
					SourceId:    "costPoolID"
				}
			}
		}
		totalCostPoolAllocation: {
			Type:        tailordb.#TypeFloat
			Description: "totalCostPoolAllocation"
			Hooks: {
				CreateExpr: "decimal(0.0)"
			}
		}
		unitCostPoolAllocation: {
			Type:        tailordb.#TypeFloat
			Description: "unitCostPoolAllocation"
			Hooks: {
				CreateExpr: "decimal(0.0)"
				UpdateExpr: """
						decimal(_value.quantity) == decimal(0.0) ? decimal(0.0) : decimal(_value.totalCostPoolAllocation) / decimal(_value.quantity)
					"""
			}
		}
		totalUnitCost: {
			Type:        tailordb.#TypeFloat
			Description: "totalUnitCost"
			Hooks: {
				CreateExpr: "decimal(_value.subtotalUnitCost)"
				UpdateExpr: """
						decimal(_value.subtotalUnitCost) + (decimal(_value.quantity) == decimal(0.0) ? decimal(0.0) : decimal(_value.totalCostPoolAllocation) / decimal(_value.quantity))
					"""
			}
		}
		receiptStatus: {
			Type:        tailordb.#TypeEnum
			Description: "inventoryType"
			AllowedValues: [
				{Value: "DRAFT", Description: "DRAFT State, meaning it can be updated"},
				{Value: "RECEIVED", Description: "CANNOT BE EDITED. RECEIVED State, items were received"},
			]
			Hooks: {
				CreateExpr: "_value == null ? 'DRAFT' : _value"
			}
		}
		receivedAt: {
			Type:        tailordb.#TypeDateTime
			Description: "shipped at"
			Hooks: {
				UpdateExpr: "_value.receiptStatus == 'RECEIVED' ? now() : null"
			}
		}
	}
	TypePermission: permissions.adminAccess
}
