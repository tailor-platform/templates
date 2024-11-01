package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

PurchaseOrder: tailordb.#Type & {
	Name:        "PurchaseOrder"
	Description: "Purchase order. A purchase order is a document issued by a buyer to a seller, indicating types, quantities, and agreed prices for products or services the seller will provide to the buyer."
	Settings: {
		BulkUpsert:          true
		PublishRecordEvents: true
	}
	Fields: {
		supplier: {
			Type:        "Supplier"
			Description: "Supplier. This field constitutes a unique key with product"
			SourceId:    "supplierID"
		}
		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "Supplier ID"
			Required:    true
		}
		quote: {
			Type:        "Quote"
			Description: "Quote. Optional the quote that this purchase order is based on"
			SourceId:    "quoteID"
		}
		quoteID: {
			Type:        tailordb.#TypeUUID
			Description: "Quote ID"
		}
		purchaseOrderDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of purchase order"
			Required:    true
		}
		reference: {
			Type:        tailordb.#TypeString
			Description: "Human readable reference number of purchase order"
			Required:    true
		}
		status: {
			Type:        tailordb.#TypeEnum
			Description: "Status of the purchase order"
			Required:    true
			AllowedValues: [
				{Value: "draft", Description: "Draft"},
				{Value: "submitted", Description: "Submitted"},
				{Value: "confirmed", Description: "Confirmed"},
				{Value: "rejected", Description: "Rejected"},
				{Value: "completed", Description: "Completed"},
				{Value: "canceled", Description: "Canceled"},
			]
		}
		submittedOn: {
			Type:        tailordb.#TypeDate
			Description: "Date of submission"
		}
		confirmedOn: {
			Type:        tailordb.#TypeDate
			Description: "Date of supplier confirmation"
		}
		rejectedOn: {
			Type:        tailordb.#TypeDate
			Description: "Date of rejection"
		}
		canceledOn: {
			Type:        tailordb.#TypeDate
			Description: "Date of cancellation"
		}
		canceledBy: {
			Type:        tailordb.#TypeEnum
			Description: "Party who canceled the purchase order"
			AllowedValues: [
				{Value: "buyer", Description: "Buyer"},
				{Value: "supplier", Description: "Supplier"},
			]
		}
		completedOn: {
			Type:        tailordb.#TypeDate
			Description: "Date of completion"
		}
		createdAt: tailordb.CreatedAtField
	}
	TypePermission: permissions.adminAccess
}

PurchaseOrderLineItem: tailordb.#Type & {
	Name:        "PurchaseOrderLineItem"
	Description: "Purchase order line item. A line item in a purchase order"
	Settings: {
		BulkUpsert: true,
		Aggregation: true
	}
	Fields: {
		displayOrder: {
			Type:        tailordb.#TypeInt
			Description: "Index of the item in the purchase order"
			Required:    true
		}
		purchaseOrder: {
			Type:        "PurchaseOrder"
			Description: "Purchase Order"
			SourceId:    "purchaseOrderID"
		}
		purchaseOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "Purchase Order ID"
			Required:    true
		}
		product: {
			Type:        "Product"
			Description: "Product"
			SourceId:    "productID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
			Required:    true
		}
		quoteLineItem: {
			Type:        "QuoteLineItem"
			Description: "Quote Line Item. Optional the quote line item that this purchase order line item is based on"
			SourceId:    "quoteLineItemID"
		}
		quoteLineItemID: {
			Type:        tailordb.#TypeUUID
			Description: "Quote Line Item ID"
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Description of the item"
		}
		price: {
			Type:        tailordb.#TypeFloat
			Description: "Price of the item"
			Required:    true
		}
		quantity: {
			Type:        tailordb.#TypeFloat
			Description: "Quantity of the item"
			Required:    true
		}
		total: {
			Type:        tailordb.#TypeFloat
			Description: "Total"
			Hooks: {
				CreateExpr: "_value.price * _value.quantity"
				UpdateExpr: CreateExpr
			}
		}
	}
	TypePermission: permissions.adminAccess
}
