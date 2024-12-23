package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

PurchaseOrderLineItem: commonType.#CommonType & {
	Name:        "PurchaseOrderLineItem"
	Description: "PurchaseOrderLineItem model"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		purchaseOrderID: {
			Type:        tailordb.#TypeUUID
			Required:    true
			Description: "purchaseOrder ID"
		}
		purchaseOrder: {
			Type:        "PurchaseOrder"
			Description: "PurchaseOrder model. PurchaseOrder and this model is n:1."
			SourceId:    "purchaseOrderID"
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
		unitCost: {
			Type:        tailordb.#TypeFloat
			Description: "unitCost"
			Required:    true
		}
		subtotalCost: {
			Type:        tailordb.#TypeFloat
			Description: "subtotalCost"
			Hooks: {
				CreateExpr: "decimal(_value.quantity) * decimal(_value.unitCost)"
				UpdateExpr: CreateExpr
			}
		}
	}
	TypePermission: permissions.adminAccess
}
