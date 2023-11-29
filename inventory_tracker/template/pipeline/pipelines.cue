package pipelines

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"{{ .Values.cue.package }}/charts/pipeline/resolvers"
	"{{ .Values.cue.package }}/charts/pipeline/resolvers/operationShortcuts"
	"{{ .Values.cue.package }}/charts/pipeline/resolvers/basicApiOverrides"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   {{ .Values.pipeline.namespace | quote }}
	invoker:     directories.roleMap.Admin.id
	description: "Pipeline resolvers for inventory tracker"
	resolverMap: {
		"calculatePutAwayLeadTime": resolvers.calculatePutAwayLeadTime
		"calculateStockEventCalc": resolvers.calculateStockEventCalc
		"calculateDemandForecast": resolvers.calculateDemandForecast
		"calculateStockLevel": resolvers.calculateStockLevel
		"calculateReplenishmentAlert": resolvers.calculateReplenishmentAlert
		"deleteAllRecords": resolvers.deleteAllRecords
		"createPutAwayFromPurchaseOrder": operationShortcuts.createPutAwayFromPurchaseOrder
		"createShipOutFromSalesOrder": operationShortcuts.createShipOutFromSalesOrder
		"createPutAwayWithEvent": basicApiOverrides.createPutAwayWithEvent
		"createShipOutWithEvent": basicApiOverrides.createShipOutWithEvent
	}
}
