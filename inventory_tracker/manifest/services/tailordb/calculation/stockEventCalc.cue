package calculation

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

StockEventCalc: tailordb.#Type & {
	Name:        "StockEventCalc"
	Description: "Intermediate calculating table of StockEvent. Flattens Lot, PutAway, PurchaseOrder, Product, Location, and StockEvent."
	Settings: {
		Aggregation: true
	}
	Fields: {
		lot: {
			Type:        "Lot"
			Description: "Lot is the minimum unit to manage inventory here. Any stock movements has to specify a Lot for the tracability purpose"
			SourceId:    "lotID"
		}
		lotID: {
			Type:        tailordb.#TypeUUID
			Description: "Lot ID"
			Required:    true
		}
		eventDate: {
			Type:        tailordb.#TypeDate
			Description: "Date of the event"
			Required:    true
		}
		incrementalQuantity: {
			Type:        tailordb.#TypeInt
			Description: "delta of quantity. This value will be negative value if the event reduces inventory quantities"
			Required:    true
		}
		reason: {
			Type:        tailordb.#TypeString
			Description: "The reason for the stock event, such as putaway, shipout, return, adjuestment, etc."
			Required:    true
		}
		stockEventID: {
			Type:        tailordb.#TypeUUID
			Description: "Stock event ID"
			Required:    true
		}
		putAwayID: {
			Type:        tailordb.#TypeUUID
			Description: "PutAway ID"
			Required:    true
		}
		purchaseOrderID: {
			Type:        tailordb.#TypeUUID
			Description: "PurchaseOrder ID"
			Required:    true
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
			Required:    true
		}
		locationID: {
			Type:        tailordb.#TypeUUID
			Description: "Location ID"
			Required:    true
		}
		sellingStartDate: {
			Type:        tailordb.#TypeDate
			Description: "Selling start date. Attribute of Product"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}