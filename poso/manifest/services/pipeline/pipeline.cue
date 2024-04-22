package pipeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/manifest/services/pipeline/resolvers"
	"tailor.build/template/environment"
)

pipeline.#Spec & {
	Namespace: environment.#app.namespace
	Resolvers: [
		resolvers.bulkUpsertAndCalculateLineItems,
		resolvers.calculateDocument,
		resolvers.calculateDocuments,
		resolvers.calculateStockEventAndUpdateStockSummary,
		resolvers.createDocumentFromDocumentWithLineItem,
		resolvers.createStockEventsFromDocument,
		resolvers.createStockHistoryFromSummary,
		resolvers.deleteAllTailorDBRecords,
		resolvers.deleteDocumentAndLines,
		resolvers.recalculateStockEventAndSummary,
		resolvers.restoreStockSummaryFromHistory,
	]
}