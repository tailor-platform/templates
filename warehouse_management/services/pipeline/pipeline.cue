package pipeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline/resolvers"
	"tailor.build/template/environment"
)

pipeline.#Spec & {
	Namespace:   environment.#app.namespace
	Description: "Pipeline resolvers for warehouse management"
	Resolvers: [
		resolvers.createGrnFromPurchaseOrder,
		resolvers.createPickingListFromSalesOrder,
		resolvers.deleteAllTailorDBRecords,
		resolvers.deleteGrnById,
		resolvers.executeGrn,
		resolvers.executePickingList,
		resolvers.deletePurchaseOrderById,
		resolvers.deleteSalesOrderById,
		resolvers.setBinAsDefault
	]
}
