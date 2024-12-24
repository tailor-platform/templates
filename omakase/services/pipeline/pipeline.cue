package pipeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline/resolvers"
	"tailor.build/template/environment"
)

pipeline.#Spec & {
	Namespace: environment.#app.namespace
	Resolvers: [
		resolvers.computeWorkOrderCost,
		resolvers.convertQuantity,
		resolvers.simulateInputRequirementByOutputQuantity,
		resolvers.simulateOutputByIngredients,
		resolvers.simulateWorkOperation,
		resolvers.previewManufacturing,
		resolvers.createManufacturingOrderAndWorkOrders,
		resolvers.removeManufacturingOrder,
		resolvers.computeManufacturingOrderCost,
		resolvers.computeWorkOrderCostRealDuration,
		resolvers.setWorkOrderStartAndEndDate,
		resolvers.planManufacturingOrder,
		resolvers.unPlanManufacturingOrder,
		resolvers.previewMoBatch,
		resolvers.addBatchMo,
		resolvers.planBatchManufacturingOrder,
		resolvers.removeBatchManufacturingOrder,
		resolvers.unPlanBatchManufacturingOrder,
		resolvers.updateManufacturingOrderBatchStatus,
		resolvers.updateManufacturingOrderStatus,
		resolvers.cancelManufacturingOrder,
		resolvers.allocateInventoryItem,
		resolvers.consumeAllocatedInventoryItem,
		resolvers.moveWoToWaitingForComponents,
		resolvers.moveWoToReady,
		resolvers.moveWoToInProgress,
		resolvers.moveWoToFinish,
		resolvers.removeAllocatedInventoryItem,
		resolvers.scrapConsumedInventoryItem,
		resolvers.cancelWorkOrder,
		resolvers.configureBomItemsWithOperation,
		resolvers.computeBatchMoCost,
		resolvers.validateBomItemWithOperations,
		resolvers.consumeInventoryItem,
		resolvers.createNestedManufacturingOrder,
		resolvers.workOrderStatusTransitionRecord,
		resolvers.manufacturingOrderStatusTransitionRecord,

// IMS
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
