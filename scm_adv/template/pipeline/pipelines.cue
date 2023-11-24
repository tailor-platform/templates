package pipelines

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"{{ .Values.cue.package }}/charts/pipeline/resolvers"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   {{ .Values.pipeline.namespace | quote }}
	invoker:     directories.roleMap.Admin.id
	description: "SCM pipeline resolver"
	resolverMap: {
		"cancelOrder":       resolvers.cancelOrder
		"changeToDELIVERED": resolvers.changeToDELIVERED
		"changeToINTRANSIT": resolvers.changeToINTRANSIT
		"editOrder":         resolvers.editOrder
		"editPurchase":      resolvers.editPurchase
		"placeOrder":        resolvers.placeOrder
		"placePurchase":     resolvers.placePurchase
		"transferInventory": resolvers.transferInventory
	}
}
