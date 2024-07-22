package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

StockEvent: tailordb.#Type & {
	Name:        "StockEvent"
	Description: "StockEvent model"
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
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
