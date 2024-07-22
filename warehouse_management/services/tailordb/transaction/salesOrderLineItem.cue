package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

SalesOrderLineItem: tailordb.#Type & {
	Name:        "SalesOrderLineItem"
	Description: "SalesOrderLineItem model"
	Fields: {
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the product."
		}

		product: {
			Type:        "Product"
			Description: "Product model. salesOrderLineItem and Product is n:1."
			SourceId:    "productID"
		}

		salesOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the sales order."
		}

		salesOrder: {
			Type:        "SalesOrder"
			Description: "SalesOrder model. salesOrderLineItem and salesOrder is n:1."
			SourceId:    "salesOrderID"
		}

		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of the product ordered."
		}
	}
	TypePermission: permissions.employee
}
