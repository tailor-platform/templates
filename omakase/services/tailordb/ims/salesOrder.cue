package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

SalesOrder: commonType.#CommonType & {
	Name:        "SalesOrder"
	Description: "SalesOrder model"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		orderNumber: {
			Type:        tailordb.#TypeInt
			Description: "Order number"
		}
		customerID: {
			Type:           tailordb.#TypeUUID
			Description:    "Contact model. Contact and this model is n:1"
			ForeignKey:     true
			ForeignKeyType: "Contact"
		}
		customer: {
			Type:        "Contact"
			Description: "Customer contact"
			SourceId:    "customerID"
		}
		shopifyID: {
			Type:        tailordb.#TypeString
			Description: "Shopify order ID"
		}
		cancelReason: {
			Type:        tailordb.#TypeString
			Description: "Reason for cancellation"
		}
		cancelledAt: {
			Type:        tailordb.#TypeDateTime
			Description: "Cancellation date"
		}
		currency: {
			Type:        tailordb.#TypeString
			Description: "Currency"
		}
		currentSubtotalPrice: {
			Type:        tailordb.#TypeString
			Description: "Current subtotal price"
		}
		customerName: {
			Type:        tailordb.#TypeString
			Description: "Customer name"
		}
		customerEmail: {
			Type:        tailordb.#TypeString
			Description: "Customer email"
		}
		createdAt: tailordb.CreatedAtField
		shopifyCreatedAt: {
			Type:        tailordb.#TypeDateTime
			Description: "Shopify created at"
		}
		shipStationOrderStatus: {
			Type:        tailordb.#TypeEnum
			Description: "inventoryType"
			AllowedValues: [
				{Value: "not_sent", Description: "Not yet sent to ShipStation. Order is awaiting payment"},
				{Value: "changes_not_sent", Description: "CHANGES NOT SENT. Order has been changed but not sent to ShipStation"},
				{Value: "awaiting_payment", Description: "AWAITING PAYMENT. Order is awaiting payment"},
				{Value: "shipped", Description: "SHIPPED. Order has been shipped"},
			]
			Hooks: {
				CreateExpr: "_value.shopifyID == null ? 'awaiting_payment' : 'not_sent'"
			}
		}
		shippedAt: {
			Type:        tailordb.#TypeDateTime
			Description: "shipped at"
			Hooks: {
				UpdateExpr: "_value.shipStationOrderStatus == 'shipped' ? now() : null"
			}
		}
	}
	TypePermission: permissions.adminAccess
}
