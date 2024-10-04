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
		resolvers.computeWorkOrderCost,
		resolvers.convertQuantity,
		resolvers.simulateInputRequirementByOutputQuantity,
		resolvers.simulateOutputByIngredients,
		resolvers.simulateWorkOperation,
		resolvers.previewManufacturing,
		resolvers.createManufacturingOrderAndWorkOrders,
		resolvers.cancelManufacturingOrder,
		resolvers.computeManufacturingOrderCost,
		resolvers.computeWorkOrderCostRealDuration,
		resolvers.setWorkOrderStartAndEndDate,
		resolvers.planManufacturingOrder,
		resolvers.unPlanManufacturingOrder,
	]
}
