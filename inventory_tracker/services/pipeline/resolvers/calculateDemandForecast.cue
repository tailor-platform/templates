package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

calculateDemandForecast: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "calculateDemandForecast"
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
		!isNull(context.pipeline.createDemandForecast.result) || !isNull(context.pipeline.deleteDemandForecast.result)
		"""
	Response: {Type: pipeline.Boolean}
	Pipelines: [
		{
			Name:        "demandForecasts"
			Description: "Get all the DemandForecast records. This old data will be deleted in the last step."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									query demandForecasts {
								  		demandForecasts {
											collection {
												id
								    		}
								  		} 
									}"""
			}
			PostScript: """
							{
								"demandForecasts": args.demandForecasts,
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
										aggregateStockEventCalcs(query: {reason: {eq: "Ship Out"}}) {
											groupBy {
											productID
											locationID
											toDay {
												sellingStartDate
											}
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
			Name:        "createDemandForecast"
			Description: "Create DemandForecast records based on the result of the aggregation."
			Invoker:     settings.adminInvoker
			ForEach:     "args.aggregateStockEventCalcs"
			PreScript: """
							{
								"input": compact({
									"productID": each.groupBy.productID,
									"locationID": each.groupBy.locationID,
									"sumOfIncrementalQuantity": each.sum.incrementalQuantity,
									"sellingStartDate": each.groupBy.toDay.sellingStartDate,
								})
							}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation ($input: DemandForecastCreateInput) {
										createDemandForecast(input: $input) {
											id
										}
									}"""
			}
			PostScript: """
							{
								"result": args.createDemandForecast
							}"""
		},
		{
			Name:        "deleteDemandForecast"
			Description: "delete demandForecasts"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.demandForecasts.demandForecasts.collection"
			Test:        "size(context.pipeline.demandForecasts.demandForecasts.collection) > 0"
			PreScript: """
				{
					"id": each.id,
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation deleteDemandForecast($id: ID!) {
										deleteDemandForecast(id: $id)
									}"""
			}
			PostScript: """
							{
								"result": args.deleteDemandForecast
							}"""
		},
	]
}
