package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/environment"
	"tailor.build/template/manifest/services/tailordb/master"
	"tailor.build/template/manifest/services/tailordb/transaction"
	"tailor.build/template/manifest/services/tailordb/calculation"
)
tailordb.#Spec & {
	Namespace: environment.#app.namespace,
	Types: [
		{master.User},
		{master.Role},
		{master.Location},
		{master.Product},
		{master.Supplier},
		{transaction.Lot},
		{transaction.PurchaseOrder},
		{transaction.PutAway},
		{transaction.SalesOrder},
		{transaction.ShipOut},
		{transaction.StockEvent},
		{calculation.DemandForecast},
		{calculation.PutAwayCalc},
		{calculation.ReplenishmentAlert},
		{calculation.StockEventCalc},
		{calculation.StockLevel},
		{calculation.SupplierLeadTime},
	]
}
