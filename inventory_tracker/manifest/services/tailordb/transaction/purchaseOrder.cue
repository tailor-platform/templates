package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

PurchaseOrder: tailordb.#Type & {
	Name:        "PurchaseOrder"
	Description: "Model for Purchase Order. Each record of the Purchase Order represents unique combination of a Product, a Location, and a Supplier. Customization is required to wrap multiple records (line items) into one purchase order."
	Settings: {
		Aggregation: true
	}
	Fields: {
		product: {
			Type:        "Product"
			Description: "Product. This field constitutes a unique key with location"
			SourceId:    "productID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
			Required:    true
		}
		location: {
			Type:        "Location"
			Description: "Location. This field constitutes a unique key with product"
			SourceId:    "locationID"
		}
		locationID: {
			Type:        tailordb.#TypeUUID
			Description: "Location ID"
			Required:    true
		}
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
		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Order quantity"
			Required:    true

		}
		purchaseOrderDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of purchase order"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}