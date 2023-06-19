package transaction

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	accountID: {
		type:        tailordb.#FieldTypeUUID
		description: "The transaction's account ID."
		required:    true
	}
	transactionDate: {
		type:        tailordb.#FieldTypeDate
		description: "The transaction date."
		required:    true
	}
	transactionAmt: {
		type:        tailordb.#FieldTypeInteger
		description: "The transaction amount."
		required:    true
	}
	transactionType: {
		type:        tailordb.#FieldTypeString
		description: "The transaction type."
	}
	transactionMethod: {
		type:        tailordb.#FieldTypeString
		description: "The transaction method."
	}
}

Transaction: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Transaction model"
	permission:  permissions.employee
}
