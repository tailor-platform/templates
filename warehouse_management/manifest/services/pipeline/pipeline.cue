package pipeline

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline/resolvers"
    "tailor.build/template/environment"
)

pipeline.#Spec & {
    Namespace: environment.#app.namespace
    Description: "Pipeline resolvers for warehouse management"
    Resolvers: [
        resolvers.deleteAllTailorDBRecords,
        resolvers.createShipOutFromBinStock,
        resolvers.transferBinStock,
        resolvers.listPicking
    ]
}
