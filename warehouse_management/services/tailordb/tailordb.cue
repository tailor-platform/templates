package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/master"
	"tailor.build/template/services/tailordb/transaction"
	"tailor.build/template/environment"
)

tailordb.#Spec & {
	Namespace: environment.#app.namespace
	Types: [
		{master.Bin},
		{master.BinStock},
		{master.Product},
		{master.Role},
		{master.Store},
		{master.Supplier},
		{master.User},
		{master.Warehouse},
		{transaction.PurchaseOrder},
		{transaction.PurchaseOrderLineItem},
		{transaction.PutAway},
		{transaction.PutAwayLineItem},
		{transaction.SalesOrder},
		{transaction.SalesOrderLineItem},
		{transaction.ShipOut},
		{transaction.ShipOutLineItem},
	]
}
