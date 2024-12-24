package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

ShipmentLineItem: commonType.#CommonType & {
	Name:        "ShipmentLineItem"
	Description: "ShipmentLineItem model"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		shipmentID: {
			Type:        tailordb.#TypeUUID
			Description: "Shipment ID"
			Required:    true
		}
		shipment: {
			Type:        "Shipment"
			Description: "Shipment model. Shipment and this model is n:1."
			SourceId:    "shipmentID"
		}
		unitCost: {
			Type:        tailordb.#TypeFloat
			Description: "unit cost"
			Required:    true
		}
		unitPrice: {
			Type:        tailordb.#TypeFloat
			Description: "unit price"
			Required:    true
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
			Required:    true
		}
		taxable: {
			Type:        tailordb.#TypeBool
			Description: "taxable"
		}
		shipmentStatus: {
			Type:        tailordb.#TypeEnum
			Description: "inventoryType"
			AllowedValues: [
				{Value: "DRAFT", Description: "DRAFT State, meaning it can be updated"},
				{Value: "ONHOLD", Description: "CANNOT BE EDITED. ONHOLD State, meaning inventory is on hold on hold"},
				{Value: "SHIPPED", Description: "CANNOT BE EDITED. SHIPPED State, items were shipped"},
			]
			Hooks: {
				CreateExpr: "_value == null ? 'DRAFT' : _value"
			}
		}
		shippedAt: {
			Type:        tailordb.#TypeDateTime
			Description: "shipped at"
			Hooks: {
				UpdateExpr: "_value.shipmentStatus == 'SHIPPED' ? now() : null"
			}
		}
	}
	TypePermission: permissions.adminAccess
}
