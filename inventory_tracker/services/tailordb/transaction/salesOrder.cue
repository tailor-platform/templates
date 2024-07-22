package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

SalesOrder: tailordb.#Type & {
	Name:        "SalesOrder"
	Description: "Model for Sales Order. Each record of the Sales Order should specify a lot. Customization is required to wrap multiple records (line items) into one purchase order."
	Settings: {
		Aggregation: true
	}
	Fields: {
		lot: {
			Type:        "Lot"
			Description: "Lot. Each record of the Sales Order should specify a lot for tracability purpose."
			SourceId:    "lotID"
		}
		lotID: {
			Type:        tailordb.#TypeUUID
			Description: "Lot ID"
			Required:    true
		}
		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Order quantity"
			Required:    true
		}
		salesOrderDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of sales order"
			Required:    true
		}
		customerName: {
			Type:        tailordb.#TypeString
			Description: "Customer name"
			Required:    false
		}
		deliveryAddress: {
			Type:        tailordb.#TypeString
			Description: "Delivery address of the customer"
			Required:    false
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
