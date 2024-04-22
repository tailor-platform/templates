package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

calculateStockLevel: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "calculateStockLevel"
	Description: """
	The purpose of this Pipeline is to refresh DemandForecast table by aggregating the StockEventCalc table to calculate the average demand for each product and location combination, then store the result to DemandForecast.
	This Pipeline follows the following steps:
	1. Get all the DemandForecast records. This old data will be deleted in the last step.
	2. Refresh the StockEventCalc records by running calculateStockEventCalc pipeline.
	3. Aggregate the StockEventCalc records to calculate the average demand time for each product and location.
	4. Create DemandForecast records based on the result of the aggregation.
	5. Delete the DemandForecast records created prior to the the update.
	"""
	PostScript: """
	!isNull(context.pipeline.updateStockLevel.result) || !isNull(context.pipeline.deletestockLevels.result)
	"""
	Response: { Type: pipeline.Boolean }	
	Pipelines: [
		{
			Name:        "stockLevels"
			Description: "Get all the stockLevels records. This old data will be deleted in the last step."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query stockLevels{
					stockLevels{
						collection{
						id
						}
					}
				}"""
			}
			PostScript: """
			{
				"stockLevels": args.stockLevels,
			}"""
		},
		{
			Name:        "calculateStockEventCalc"
			Description: "Refresh the StockEventCalc records by running calculateStockEventCalc pipeline."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation calculateStockEventCalc{
			  		calculateStockEventCalc
				}"""
			}
			PostScript: """
			{
				"result": args.calculateStockEventCalc
			}"""
		},
		{
			Name:        "aggregateStockEventCalcs"
			Description: "Aggregate the StockEventCalc records to calculate the average demand time for each product and location."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query aggregateStockEventCalcs {
					aggregateStockEventCalcs {
						groupBy {
							productID
							locationID
						}
						sum {
							incrementalQuantity
						}
					}
				}"""
			}
			PostScript: """
			{
				"aggregateStockEventCalcs": args.aggregateStockEventCalcs
			}"""
		},
		{
			Name:        "createStockLevel"
			Description: "Create createStockLevel records based on the result of the aggregation."
			Invoker:     settings.adminInvoker
			ForEach:	 "args.aggregateStockEventCalcs"
			PreScript: """
			{
				"input": {
					"productID": each.groupBy.productID,
					"locationID": each.groupBy.locationID,
					"sumOfIncrementalQuantity": each.sum.incrementalQuantity,
				}
			}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation ($input: StockLevelCreateInput) {
					createStockLevel(input: $input) {
						id
						productID
						locationID
					}
				}"""
			}
			PostScript: """
			{
				"result": args.createStockLevel
			}"""
		},
		{
			Name:        "prepStockLevelCreateInput"
			Description: "Fetch DemandForecast records based on the result of the aggregation."
			Invoker:     settings.adminInvoker
			ForEach:	 "args"
			PreScript: """
			{				
				"productID": each.result.productID,
				"locationID": each.result.locationID,
			}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query demandForecasts($productID: ID, $locationID: ID) {
					demandForecasts(
						query: {productID: {eq: $productID}, locationID: {eq: $locationID}}
					) {
						collection {
							dailyDemand
						}
					}
					stockLevels(query: {productID: {eq: $productID}, locationID: {eq: $locationID}}) {
						collection {
							id
						}
					}
				}"""
			}
			PostScript: """
			{
				"result": {
					"dailyDemand": args.demandForecasts.collection == [] ? null : args.demandForecasts.collection[0].dailyDemand,
					"id": args.stockLevels.collection == [] ? null : args.stockLevels.collection[0].id,
				}
			}"""
		},
		{
			Name:        "updateStockLevel"
			Description: "update createStockLevel records based on the result of the aggregation."
			Invoker:     settings.adminInvoker
			ForEach:	 "args"
			PreScript: """
			{
				"id": each.result.id,
				"dailyDemand": each.result.dailyDemand,
			}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation ($id: ID!, $dailyDemand: Float) {
					updateStockLevel(id: $id, input: {dailyDemand: $dailyDemand}) {
						id
					}
				}"""
			}
			PostScript: """
			{
				"result": args.updateStockLevel
			}"""
		},
		{
			Name:        "deletestockLevels"
			Description: "delete stockLevels"
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.stockLevels.stockLevels.collection"
			Test: 		 "size(context.pipeline.stockLevels.stockLevels.collection) > 0"
			PreScript: """
			{
				"id": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deleteStockLevels($id: ID!) {
			  		deleteStockLevel(id: $id)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteStockLevel
			}"""
		},
	]
}
