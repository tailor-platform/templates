package pipeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline/resolvers"
)

pipeline.#Spec & {
	Namespace: environment.#app.namespace
	Resolvers: [
		resolvers.createAdvanceShipmentNoticeForInvoice,
		resolvers.createGoodsReceivedNoteForAsn,
		resolvers.createInvoiceForPurchaseOrder,
		resolvers.createPurchaseOrderForQuote,
		resolvers.createQuoteForRequestForQuote,
		resolvers.reconcileAdvanceShipmentNotice,
		resolvers.reconcileInvoice,
		resolvers.reconcilePurchaseOrder,
	]
}
