package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

PurchaseOrderLineItem: tailordb.#Type & {
	Name:        "PurchaseOrderLineItem"
	Description: "PurchaseOrderLineItem model"
	Fields: {
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the product."
		}

		product: {
			Type:        "Product"
			Description: "Product model. PurchaseOrderLineItem and Product is n:1."
			SourceId:    "productID"
		}

		purchaseOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the purchase order. This is a foreign key to the PurchaseOrder model."
		}

		purchaseOrder: {
			Type:        "PurchaseOrder"
			Description: "PurchaseOrder model. PurchaseOrderLineItem and PurchaseOrder is n:1."
			SourceId:    "purchaseOrderID"
		}

		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of the product ordered."
		}
	}
	TypePermission: permissions.employee
}
