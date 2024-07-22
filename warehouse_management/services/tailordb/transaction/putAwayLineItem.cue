package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

PutAwayLineItem: tailordb.#Type & {
	Name:        "PutAwayLineItem"
	Description: "PutAwayLineItem model"
	Fields: {
		putAwayID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the put-away."
		}

		putAway: {
			Type:        "PutAway"
			Description: "PutAway model. PutAwayLineItem and PutAway is n:1."
			SourceId:    "putAwayID"
		}

		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the product."
		}

		product: {
			Type:        "Product"
			Description: "Product model. PutAwayLineItem and Product is n:1."
			SourceId:    "productID"
		}

		binID: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier for the bin."
		}

		bin: {
			Type:        "Bin"
			Description: "Bin model. PutAwayLineItem and Bin is n:1."
			SourceId:    "binID"
		}

		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of the product being put away."
		}
	}
	TypePermission: permissions.employee
}
