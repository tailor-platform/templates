package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

Transaction: tailordb.#Type & {
	Name:        "Transaction"
	Description: "Transaction model"
	Fields: {
		accountID: {
			Type:        tailordb.#TypeUUID
			Description: "The transaction's account ID."
			Required:    true
		}
		transactionDate: {
			Type:        tailordb.#TypeDate
			Description: "The transaction date."
			Required:    true
		}
		transactionAmt: {
			Type:        tailordb.#TypeInt
			Description: "The transaction amount."
			Required:    true
		}
		transactionType: {
			Type:        tailordb.#TypeString
			Description: "The transaction type."
		}
		transactionMethod: {
			Type:        tailordb.#TypeString
			Description: "The transaction method."
		}
	}
	TypePermission: permissions.employee
}

