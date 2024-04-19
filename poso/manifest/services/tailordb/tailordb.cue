package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb/calculation"
	"tailor.build/template/manifest/services/tailordb/master"
	"tailor.build/template/manifest/services/tailordb/transaction"
	"tailor.build/template/environment"
)
tailordb.#Spec & {
	Namespace: environment.#app.namespace,
	Types: [
		{calculation.StockHistory},
		{calculation.StockSummary},
		{master.User},
		{master.DocumentStatus},
		{master.DocumentTemplate},
		{master.DocumentType},
		{master.Product},
		{master.Contact},
		{master.Role},
		{master.Tax},
		{transaction.Document},
		{transaction.LineItem},
		{transaction.StockEvent},
	]
}
