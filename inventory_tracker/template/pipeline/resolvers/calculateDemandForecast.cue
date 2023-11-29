package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

calculateDemandForecast: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "calculateDemandForecast"
	description: """
	The purpose of this Pipeline is to refresh DemandForecast table by aggregating the StockEventCalc table to caluculate the average demand for each product and location combination, then store the result to DemandForecast.
	This Pipeline follows the following steps:
	1. Get all the DemandForecast records. This old data will be deleted in the last step.
	2. Refresh the StockEventCalc records by running calculateStockEventCalc pipeline.
	3. Aggregate the StockEventCalc records to caluculate the average demand time for each product and location.
	4. Create DemandForecast records based on the result of the aggregation.
	5. Delete the DemandForecast records created prior to the the update.
	"""
	postScript: """
	!isNull(context.pipeline.createDemandForecast.result) || !isNull(context.pipeline.deleteDemandForecast.result)
	"""
	response: { type: schema.Boolean }	
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "demandForecasts"
			description: "Get all the DemandForecast records. This old data will be deleted in the last step."
			url:         settings.services.gateway
			graphqlQuery: """
			query demandForecasts {
			  demandForecasts {
			    collection {
			      id
			    }
			  }
			}"""
			postScript: """
			{
				"demandForecasts": args.demandForecasts,
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "calculateStockEventCalc"
			description: "Refresh the StockEventCalc records by running calculateStockEventCalc pipeline."
			url:         settings.services.gateway
			graphqlQuery: """
			mutation calculateStockEventCalc{
			  calculateStockEventCalc
			}"""
			postScript: """
			{
				"result": args.calculateStockEventCalc
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "aggregateStockEventCalcs"
			description: "Aggregate the StockEventCalc records to caluculate the average demand time for each product and location."
			url:         settings.services.gateway
			graphqlQuery: """
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
			postScript: """
			{
				"aggregateStockEventCalcs": args.aggregateStockEventCalcs
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "createDemandForecast"
			description: "Create DemandForecast records based on the result of the aggregation."
			url:         settings.services.gateway
			forEach:	 "args.aggregateStockEventCalcs"
			preScript: """
			{
				"input": compact({
					"productID": each.groupBy.productID,
					"locationID": each.groupBy.locationID,
					"sumOfIncrementalQuantity": each.sum.incrementalQuantity,
					"sellingStartDate": each.groupBy.toDay.sellingStartDate,
				})
			}"""
			graphqlQuery: """
			mutation ($input: DemandForecastCreateInput) {
			  createDemandForecast(input: $input) {
			    id
			  }
			}"""
			postScript: """
			{
				"result": args.createDemandForecast
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteDemandForecast"
			description: "delete demandForecasts"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.demandForecasts.demandForecasts.collection"
			test: 		 "size(context.pipeline.demandForecasts.demandForecasts.collection) > 0"
			preScript: """
			{
				"id": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteDemandForecast($id: ID!) {
			  deleteDemandForecast(id: $id)
			}"""
			postScript: """
			{
				"result": args.deleteDemandForecast
			}"""
		},
	]
}
