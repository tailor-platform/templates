package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

Invoice: tailordb.#Type & {
	Name:        "Invoice"
	Description: "Invoice model"
	Settings: {
		BulkUpsert:          true
		PublishRecordEvents: true
	}
	Fields: {
		supplier: {
			Type:        "Supplier"
			Description: "Supplier"
			SourceId:    "supplierID"
		}
		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "Supplier ID"
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
		}
		invoiceDate: {
			Type:        tailordb.#TypeDate
			Description: "Invoice Date"
			Required:    true
		}
		dueDate: {
			Type:        tailordb.#TypeDate
			Description: "Due Date"
			Required:    true
		}
		reference: {
			Type:        tailordb.#TypeString
			Description: "Reference"
			Required:    true
		}
		status: {
			Type:        tailordb.#TypeEnum
			Description: "Status"
			Required:    true
			AllowedValues: [
				{Value: "draft", Description: "Draft"},
				{Value: "submitted", Description: "Submitted"},
				{Value: "shipped", Description: "Shipped"},
				{Value: "paid", Description: "Paid"},
				{Value: "void", Description: "Void"},
			]
		}
		submittedOn: {
			Type:        tailordb.#TypeDate
			Description: "Submitted On"
		}
		voidedOn: {
			Type:        tailordb.#TypeDate
			Description: "Voided On"
		}
		shippedOn: {
			Type:        tailordb.#TypeDate
			Description: "Shipped On"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.adminAccess
}

InvoiceLineItem: tailordb.#Type & {
	Name:        "InvoiceLineItem"
	Description: "Invoice Line Item model"
	Settings: {
		BulkUpsert: true,
		Aggregation: true
	}
	Fields: {
		displayOrder: {
			Type:        tailordb.#TypeInt
			Description: "Display Order"
			Required:    true
		}
		invoice: {
			Type:        "Invoice"
			Description: "Invoice"
			SourceId:    "invoiceID"
		}
		invoiceID: {
			Type:        tailordb.#TypeUUID
			Description: "Invoice ID"
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
		purchaseOrderLineItem: {
			Type:        "PurchaseOrderLineItem"
			Description: "Purchase Order Line Item"
			SourceId:    "purchaseOrderLineItemID"
		}
		purchaseOrderLineItemID: {
			Type:        tailordb.#TypeUUID
			Description: "Purchase Order Line Item ID"
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Description"
		}
		price: {
			Type:        tailordb.#TypeFloat
			Description: "Price"
			Required:    true
		}
		quantity: {
			Type:        tailordb.#TypeFloat
			Description: "Quantity"
			Required:    true
		}
		total: {
			Type:        tailordb.#TypeFloat
			Description: "Total"
			Hooks: {
				CreateExpr: "_value.price * _value.quantity"
				UpdateExpr: "_value.price * _value.quantity"
			}
		}
	}
	TypePermission: permissions.adminAccess
}
