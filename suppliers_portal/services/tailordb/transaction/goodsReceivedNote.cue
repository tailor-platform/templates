package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

GoodsReceivedNote: tailordb.#Type & {
	Name:        "GoodsReceivedNote"
	Description: "Model for Goods Received Note"
	Settings: {
		BulkUpsert:          true
		PublishRecordEvents: true
	}
	Fields: {
		grnDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of the ASN."
		}
		reference: {
			Type:        tailordb.#TypeString
			Description: "Reference of the ASN."
			Required:    true
		}
		invoice: {
			Type:        "Invoice"
			Description: "Invoice of the ASN."
			SourceId:    "invoiceID"
		}
		invoiceID: {
			Type:        tailordb.#TypeUUID
			Description: "Invoice id of the ASN."
			Required:    true
		}
		supplier: {
			Type:        "Supplier"
			Description: "Supplier of the ASN."
			SourceId:    "supplierID"
		}
		supplierID: {
			Type:        tailordb.#TypeUUID
			Description: "Supplier id of the ASN."
			Required:    true
		}
		advanceShipmentNotice: {
			Type:        "AdvanceShipmentNotice"
			Description: "Advance Shipment Notice of the ASN."
			SourceId:    "advanceShipmentNoticeID"
		}
		advanceShipmentNoticeID: {
			Type:        tailordb.#TypeUUID
			Description: "Advance Shipment Notice id of the ASN."
			Required:    true
		}
		status: {
			Type:        tailordb.#TypeEnum
			Description: "Status of the ASN."
			AllowedValues: [
				{Value: "draft", Description: "Draft"},
				{Value: "confirmed", Description: "Confirmed"},
			]
		}
		createdAt: tailordb.CreatedAtField
	}
	TypePermission: permissions.adminAccess
}

GoodsReceivedNoteLineItem: tailordb.#Type & {
	Name:        "GoodsReceivedNoteLineItem"
	Description: "Model for Goods Received Note Line Item"
	Settings: {
		BulkUpsert: true
		Aggregation: true
	}
	Fields: {
		displayOrder: {
			Type:        tailordb.#TypeInt
			Description: "Display order of the ASN Line Item."
		}
		goodsReceivedNote: {
			Type:        "GoodsReceivedNote"
			Description: "Goods Received Note of the ASN Line Item."
			SourceId:    "goodsReceivedNoteID"
		}
		goodsReceivedNoteID: {
			Type:        tailordb.#TypeUUID
			Description: "Goods Received Note id of the ASN Line Item."
			Required:    true
		}
		invoiceLineItem: {
			Type:        "InvoiceLineItem"
			Description: "Invoice Line Item of the ASN Line Item."
			SourceId:    "invoiceLineItemID"
		}
		invoiceLineItemID: {
			Type:        tailordb.#TypeUUID
			Description: "Invoice Line Item id of the ASN Line Item."
		}
		advanceShipmentNoticeLineItem: {
			Type:        "AdvanceShipmentNoticeLineItem"
			Description: "Advance Shipment Notice Line Item of the ASN Line Item."
			SourceId:    "advanceShipmentNoteLineItemID"
		}
		advanceShipmentNoteLineItemID: {
			Type:        tailordb.#TypeUUID
			Description: "Advance Shipment Note Line Item id of the ASN Line Item."
		}
		product: {
			Type:        "Product"
			Description: "Product of the ASN Line Item."
			SourceId:    "productID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product id of the ASN Line Item."
			Required:    true
		}
		quantity: {
			Type:        tailordb.#TypeFloat
			Description: "Quantity of the ASN Line Item."
			Required:    true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Description of the ASN Line Item."
		}
	}
	TypePermission: permissions.adminAccess
}
