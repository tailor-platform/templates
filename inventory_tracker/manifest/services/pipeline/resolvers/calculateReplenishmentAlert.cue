package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

calculateReplenishmentAlert: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "calculateReplenishmentAlert"
	Description: """
	The purpose of this Pipeline is to refresh DemandForecast table by aggregating the StockEventCalc table to calculate the average demand for each product and location combination, then store the result to DemandForecast.
	This Pipeline follows the following steps:
	1. Get all the DemandForecast records. This old data will be deleted in the last step.
	2. Refresh the StockEventCalc records by running calculateStockEventCalc pipeline.
	3. Aggregate the StockEventCalc records to calculate the average demand time for each product and location.
	4. Create DemandForecast records based on the result of the aggregation.
	5. Delete the DemandForecast records created prior to the the update.
	"""
	Response: { Type: pipeline.Boolean }	
	PostScript: """
	!isNull(context.pipeline.updateReplenishmentAlert.result) || !isNull(context.pipeline.deletereplenishmentAlerts.result)
	"""
	Pipelines: [
		{
			Name:        "replenishmentAlerts"
			Description: "Get all the stockLevels records. This old data will be deleted in the last step."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query replenishmentAlerts{
					replenishmentAlerts{
						collection{
							id
						}
					}
				}"""
			}
			PostScript: """
			{
				"replenishmentAlerts": args.replenishmentAlerts,
			}"""
		},
		{
			Name:        "aggregateSupplierLeadTimes"
			Description: "Get all the stockLevels records. This old data will be deleted in the last step."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query aggregateSupplierLeadTimes{
					aggregateSupplierLeadTimes{
						max{
							averageLeadTime
						}
						groupBy{
							productID
							locationID
						}
					}
				}"""
			}
			PostScript: """
			{
				"aggregateSupplierLeadTimes": args.aggregateSupplierLeadTimes,
			}"""
		},
		{
			Name:        "createReplenishmentAlert"
			Description: "Refresh the StockEventCalc records by running calculateStockEventCalc pipeline."
			Invoker:     settings.adminInvoker
			ForEach:	 "args.aggregateSupplierLeadTimes"
			PreScript:   """
			{
				"input": {
					"productID": each.groupBy.productID,
					"locationID": each.groupBy.locationID,
					"maxLeadTime": each.max.averageLeadTime,
				}
			}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation ($input: ReplenishmentAlertCreateInput) {
					createReplenishmentAlert(input: $input) {
						id
						productID
						locationID
					}
				}"""
			}
			PostScript: """
			{
				"result": args.createReplenishmentAlert
			}"""
		},
		{
			Name:        "prepReplenishmentAlertCreateInput"
			Description: "Fetch records based on the result of the aggregation."
			Invoker:     settings.adminInvoker
			ForEach:	 "args"
			PreScript: """
			{				
				"productID": each.result.productID,
				"locationID": each.result.locationID,
			}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query ($productID: ID, $locationID: ID) {
					stockLevels(query: {productID: {eq: $productID}, locationID: {eq: $locationID}}) {
						collection {
							daysToStockout
						}
					}
					replenishmentAlerts(
						query: {productID: {eq: $productID}, locationID: {eq: $locationID}}
					) {
						collection {
							id
						}
					}
				}"""
			}
			PostScript: """
			{
				"result": {
					"daysToStockout": args.stockLevels.collection == [] ? null : args.stockLevels.collection[0].daysToStockout,
					"id": args.replenishmentAlerts.collection == [] ? null : args.replenishmentAlerts.collection[0].id,
				}
			}"""
		},
		{
			Name:        "updateReplenishmentAlert"
			Description: "update replenishmentAlert records based on the result of the aggregation."
			Invoker:     settings.adminInvoker
			ForEach:	 "args"
			PreScript: """
			{
				"id": each.result.id,
				"daysToStockout": each.result.daysToStockout,
			}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation ($id: ID!, $daysToStockout: Float) {
					updateReplenishmentAlert(id: $id, input: {daysToStockout: $daysToStockout}) {
						id
						daysToStockout
					}
				}"""
			}
			PostScript: """
			{
				"result": args.updateReplenishmentAlert
			}"""
		},
		{
			Name:        "deletereplenishmentAlerts"
			Description: "delete replenishmentAlerts"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.replenishmentAlerts.replenishmentAlerts.collection"
			Test: 		 "size(context.pipeline.replenishmentAlerts.replenishmentAlerts.collection) > 0"
			PreScript: """
			{
				"id": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteReplenishmentAlert($id: ID!) {
					deleteReplenishmentAlert(id: $id)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteReplenishmentAlert
			}"""
		},
	]
}
