package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Invoice: tailordb.#Type & {
	Name:        "Invoice"
	Description: "Invoice model"
	Fields: {
		invoiceName: {
			Type:        tailordb.#TypeString
			Description: "invoice name."
			Required:    true
		}
		invoiceCode: {
			Type:        tailordb.#TypeInt
			Description: "invoice code."
		}
		quote: {
			Type:        tailordb.#TypeInt
			Description: "Price per unit."
			Required:    true
		}
		state: {
			Type:        "State"
			Description: "state for this invoice"
			SourceId:    "stateID"
		}
		stateID: {
			Type:        tailordb.#TypeUUID
			Description: "state ID for invoice"
		}
	}
	TypePermission: permissions.strict
}
