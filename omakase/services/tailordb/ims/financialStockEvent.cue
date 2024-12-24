package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

FinancialStockEvent: commonType.#CommonType & {
	Name:        "FinancialStockEvent"
	Description: "DO NOT UPDATE FROM THE FRONT END. FinancialStockEvent model. Holds StockEvents that will not change anymore."
	Fields: {
		variantID: {
			Type:        tailordb.#TypeUUID
			Description: "Variant ID"
		}
		variant: {
			Type:        "ProductVariant"
			Description: "Variant"
			SourceId:    "variantID"
		}
		incrementalQuantity: {
			Type:        tailordb.#TypeFloat
			Description: "incrementalQuantity"
			Required:    true
		}
		unitCost: {
			Type:        tailordb.#TypeFloat
			Description: "unitCost"
			Required:    true
		}
		transactionTotalCost: {
			Type:        tailordb.#TypeFloat
			Description: "transactionTotalCost"
			Hooks: {
				CreateExpr: """
						decimal(_value.unitCost) * decimal(_value.incrementalQuantity)
					"""
				UpdateExpr: CreateExpr
			}
		}
		isOnHold: {
			Type:        tailordb.#TypeBool
			Description: "isOnHold"
			Required:    true
		}
		onHoldQuantity: {
			Type:        tailordb.#TypeFloat
			Description: "Quantity of the product that is on hold."
		}
		availableQuantity: {
			Type:        tailordb.#TypeFloat
			Description: "Available for sale quantity."
		}
		inStockQuantity: {
			Type:        tailordb.#TypeFloat
			Description: "The quantity of the product in stock."
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
		}
		averageCost: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END, use calculateStockEventAndUpdateStockSummary pipeline instead. Average cost of the product at the time of the event"
			Hooks: {
				CreateExpr: """
						( decimal(_value.onHoldQuantity) + decimal(_value.availableQuantity) ) > 0 ? decimal(_value.totalCost) /  ( decimal(_value.onHoldQuantity) + decimal(_value.availableQuantity) ) : 0
					"""
				UpdateExpr: CreateExpr
			}
		}
		receiptLineItemID: {
			Type:           tailordb.#TypeUUID
			Description:    "ReceiptLineItem where the StockEvent come from"
			ForeignKey:     true
			ForeignKeyType: "ReceiptLineItem"
		}
		receiptLineItem: {
			Type:        "ReceiptLineItem"
			Description: "ReceiptLineItem model. ReceiptLineItem and this model is 1:1. One stock event is only related o either one receipt or shipment"
			SourceId:    "receiptLineItemID"
		}
		shipmentLineItemID: {
			Type:           tailordb.#TypeUUID
			Description:    "Shipment where the StockEvents come from"
			ForeignKey:     true
			ForeignKeyType: "ShipmentLineItem"
		}
		shipmentLineItem: {
			Type:        "ShipmentLineItem"
			Description: "ShipmentLineItem model. ShipmentLineItem and this model is 1:1. One stock event is only related o either one receipt or shipment."
			SourceId:    "shipmentLineItemID"
		}
		operationalStockEventID: {
			Type:           tailordb.#TypeUUID
			Description:    "OperationalStockEvent where the StockEvents come from"
			ForeignKey:     true
			ForeignKeyType: "OperationalStockEvent"
			Required:       true
		}
		operationalStockEvent: {
			Type:        "OperationalStockEvent"
			Description: "OperationalStockEvent model. OperationalStockEvent and this model is n:1. One stock event is only related o either one receipt or shipment."
			SourceId:    "operationalStockEventID"
		}
	}
	TypePermission: permissions.financialStockEventPermissions
}
