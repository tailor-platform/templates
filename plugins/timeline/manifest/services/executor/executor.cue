package executor

import (
  "github.com/tailor-platform/tailorctl/schema/v2/executor"
  "tailor.build/template/manifest/services/executor/timeline"
)

executor.#Spec & {
  Executors: [
    timeline.#quoteCreated,
    timeline.#supplierCreated,
    timeline.#requestForQuoteAssigned,
    timeline.#purchaseOrderCreated,
    timeline.#purchaseOrderConfirmed
  ]
}
