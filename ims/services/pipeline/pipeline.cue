package pipeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline/resolvers"
	"tailor.build/template/environment"
)

pipeline.#Spec & {
	Namespace: environment.#app.namespace
	Resolvers: [
		resolvers.deleteAllTailorDBRecords,
		resolvers.allocateCost,
		resolvers.allocateCostForOpenCostPools,
		resolvers.calculateStockEventAndUpdateStockSummary,
		resolvers.recalculateStockEventAndSummary,
		resolvers.copyStockEventsToFinancialLedger,
		resolvers.createStockEventsFromReceiptLineItems,
		resolvers.createStockEventsFromShipmentLineItems,
		resolvers.createShipmentFromSalesOrder,
		resolvers.createInvoiceFromShipment,
		resolvers.createReceiptFromPurchaseOrder,
	]
}
