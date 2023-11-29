package graphqlseed

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGraphqlSeed
	spec:    manifest.#SpecGraphqlSeed & {
		mutations: [
			{
				query: """
                mutation calculateDemandForecast{
                  calculateDemandForecast
                }"""
            },
            {
				query: """
                mutation calculateStockLevel{
                  calculateStockLevel
                }"""
            },	
            {
				query: """
                mutation calculatePutAwayLeadTime{
                  calculatePutAwayLeadTime
                }"""
            },	
            {
				query: """
                mutation calculateReplenishmentAlert{
                  calculateReplenishmentAlert
                }"""
            },	

		]
	}
}
