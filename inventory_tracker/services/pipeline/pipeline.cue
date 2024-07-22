package pipeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline/resolvers"
	"tailor.build/template/environment"
)

pipeline.#Spec & {
	Namespace: environment.#app.namespace
	Resolvers: [
		resolvers.calculateDemandForecast,
		resolvers.calculatePutAwayLeadTime,
		resolvers.calculateReplenishmentAlert,
		resolvers.calculateStockEventCalc,
		resolvers.calculateStockLevel,
		resolvers.deleteAllRecords,
		resolvers.createPutAwayWithEvent,
		resolvers.createShipOutWithEvent,
		resolvers.createPutAwayFromPurchaseOrder,
		resolvers.createShipOutFromSalesOrder,
	]
}
