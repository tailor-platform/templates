package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

Receipt: commonType.#CommonType & {
	Name:        "Receipt"
	Description: "Receipt model"
	Fields: {
		receiptNumber: {
			Type:        tailordb.#TypeString
			Description: "Receipt number"
		}
		supplierID: {
			Type:           tailordb.#TypeUUID
			Description:    "Supplier ID"
			ForeignKey:     true
			ForeignKeyType: "Contact"
		}
		supplier: {
			Type:        "Contact"
			Description: "Supplier model. Supplier and this model is n:1."
			SourceId:    "supplierID"
		}
		purchaseOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "purchaseOrder ID"
		}
		purchaseOrder: {
			Type:        "PurchaseOrder"
			Description: "PurchaseOrder model. PurchaseOrder and this model is n:1."
			SourceId:    "purchaseOrderID"
		}
		date: {
			Type:        tailordb.#TypeDateTime
			Description: "date"
		}
		receiptStatus: {
			Type:        tailordb.#TypeEnum
			Description: "inventoryType"
			AllowedValues: [
				{Value: "OPEN", Description: "OPEN State, meaning it can be updated"},
				{Value: "CLOSED", Description: "CANNOT BE EDITED. RECEIVED State, items were received"},
			]
			Hooks: {
				CreateExpr: "_value == null ? 'OPEN' : _value"
			}
		}
	}
	TypePermission: permissions.adminAccess
}
