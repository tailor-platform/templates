package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

AdvanceShipmentNotice: tailordb.#Type & {
	Name:        "AdvanceShipmentNotice"
	Description: "Model for Advance Shipment Notice"
	Settings: {
		BulkUpsert:          true
		PublishRecordEvents: true
	}
	Fields: {
		asnDate: {
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
		trackingNumber: {
			Type:        tailordb.#TypeString
			Description: "Tracking number of the ASN."
		}
		carrier: {
			Type:        tailordb.#TypeString
			Description: "Carrier company of shipment."
		}
		shipmentDate: {
			Type:        tailordb.#TypeDate
			Description: "Shipment date of the ASN."
		}
		expectedDeliveryDate: {
			Type:        tailordb.#TypeDate
			Description: "Expected delivery of shipment."
		}
		containerQuantity: {
			Type:        tailordb.#TypeInt
			Description: "Containers count of the shipment."
		}
		weight: {
			Type:        tailordb.#TypeFloat
			Description: "Weight of the ASN."
		}
		status: {
			Type:        tailordb.#TypeEnum
			Description: "Status of the ASN."
			AllowedValues: [
				{Value: "draft", Description: "Draft status of the ASN."},
				{Value: "submitted", Description: "Submitted status of the ASN."},
				{Value: "received", Description: "Received status of the ASN."},
				{Value: "rejected", Description: "Rejected status of the ASN."},
			]
		}
		submittedOn: {
			Type:        tailordb.#TypeDate
			Description: "Submission date of the ASN."
		}
		createdAt: tailordb.CreatedAtField
	}
	TypePermission: permissions.adminAccess
}

AdvanceShipmentNoticeLineItem: tailordb.#Type & {
	Name:        "AdvanceShipmentNoticeLineItem"
	Description: "Model for Advance Shipment Notice Line Item"
	Settings: {
		BulkUpsert: true,
		Aggregation: true
	}
	Fields: {
		displayOrder: {
			Type:        tailordb.#TypeInt
			Description: "Display order of the ASN Line Item."
		}
		advanceShipmentNotice: {
			Type:        "AdvanceShipmentNotice"
			Description: "Advance Shipment Notice of the ASN Line Item."
			SourceId:    "advanceShipmentNoticeID"
		}
		advanceShipmentNoticeID: {
			Type:        tailordb.#TypeUUID
			Description: "Advance Shipment Notice id of the ASN Line Item."
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
			Required:    true
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
