package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

SalesOrderLineItem: commonType.#CommonType & {
	Name:        "SalesOrderLineItem"
	Description: "SalesOrderLineItem model"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		shopifyID: {
			Type:        tailordb.#TypeString
			Description: "Shopify product ID"
		}
		salesOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "salesOrder ID"
		}
		salesOrder: {
			Type:        "SalesOrder"
			Description: "SalesOrder model. SalesOrder and this model is n:1."
			SourceId:    "salesOrderID"
		}
		variantID: {
			Type:        tailordb.#TypeUUID
			Description: "Variant ID"
		}
		variant: {
			Type:        "ProductVariant"
			Description: "Variant"
			SourceId:    "variantID"
		}
		quantity: {
			Type:        tailordb.#TypeFloat
			Description: "quantity"
		}
		unitPrice: {
			Type:        tailordb.#TypeFloat
			Description: "unitPrice"
		}
		subtotalPrice: {
			Type:        tailordb.#TypeFloat
			Description: "subtotalCost"
			Hooks: {
				CreateExpr: """
						decimal(_value.quantity) * decimal(_value.unitPrice)
					"""
				UpdateExpr: CreateExpr
			}
		}
		unitCompareAtPrice: {
			Type:        tailordb.#TypeFloat
			Description: "unitCompareAtPrice"
		}
		discount: {
			Type:        tailordb.#TypeFloat
			Description: "discount"
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "name"
		}
		sku: {
			Type:        tailordb.#TypeString
			Description: "sku"
		}
		requiresShipping: {
			Type:        tailordb.#TypeBool
			Description: "requiresShipping"
		}
		taxable: {
			Type:        tailordb.#TypeBool
			Description: "taxable"
		}
		fulfillmentStatus: {
			Type:        tailordb.#TypeEnum
			Description: "fulfillmentStatus"
			AllowedValues: [
				{Value: "FULFILLED", Description: "FULFILLED item"},
				{Value: "PENDING", Description: "PENDING item"},
			]
		}
	}
	TypePermission: permissions.adminAccess
}
