package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

calculateStockLevel: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "calculateStockLevel"
	description: """
	The purpose of this Pipeline is to refresh DemandForecast table by aggregating the StockEventCalc table to calculate the average demand for each product and location combination, then store the result to DemandForecast.
	This Pipeline follows the following steps:
	1. Get all the DemandForecast records. This old data will be deleted in the last step.
	2. Refresh the StockEventCalc records by running calculateStockEventCalc pipeline.
	3. Aggregate the StockEventCalc records to calculate the average demand time for each product and location.
	4. Create DemandForecast records based on the result of the aggregation.
	5. Delete the DemandForecast records created prior to the the update.
	"""
	postScript: """
	size(context.pipeline.updateStockLevel)>0 || size(context.pipeline.deletestockLevels)>0
	"""
	response: { type: schema.Boolean }	
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "stockLevels"
			description: "Get all the stockLevels records. This old data will be deleted in the last step."
			url:         settings.services.gateway
			graphqlQuery: """
			query stockLevels{
			  stockLevels{
			    collection{
			      id
			    }
			  }
			}"""
			postScript: """
			{
				"stockLevels": args.stockLevels,
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
			description: "Aggregate the StockEventCalc records to calculate the average demand time for each product and location."
			url:         settings.services.gateway
			graphqlQuery: """
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
			postScript: """
			{
				"aggregateStockEventCalcs": args.aggregateStockEventCalcs
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "createStockLevel"
			description: "Create createStockLevel records based on the result of the aggregation."
			url:         settings.services.gateway
			forEach:	 "args.aggregateStockEventCalcs"
			preScript: """
			{
				"input": {
					"productID": each.groupBy.productID,
					"locationID": each.groupBy.locationID,
					"sumOfIncrementalQuantity": each.sum.incrementalQuantity,
				}
			}"""
			graphqlQuery: """
			mutation ($input: StockLevelCreateInput) {
			  createStockLevel(input: $input) {
			    id
				productID
				locationID
			  }
			}"""
			postScript: """
			{
				"result": args.createStockLevel
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "prepStockLevelCreateInput"
			description: "Fetch DemandForecast records based on the result of the aggregation."
			url:         settings.services.gateway
			forEach:	 "args"
			preScript: """
			{				
				"productID": each.result.productID,
				"locationID": each.result.locationID,
			}"""
			graphqlQuery: """
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
			postScript: """
			{
				"result": {
					"dailyDemand": args.demandForecasts.collection == [] ? null : args.demandForecasts.collection[0].dailyDemand,
					"id": args.stockLevels.collection == [] ? null : args.stockLevels.collection[0].id,
				}
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "updateStockLevel"
			description: "update createStockLevel records based on the result of the aggregation."
			url:         settings.services.gateway
			forEach:	 "args"
			preScript: """
			{
				"id": each.result.id,
				"dailyDemand": each.result.dailyDemand,
			}"""
			graphqlQuery: """
			mutation ($id: ID!, $dailyDemand: Float) {
			  updateStockLevel(id: $id, input: {dailyDemand: $dailyDemand}) {
			    id
			  }
			}"""
			postScript: """
			{
				"result": args.updateStockLevel
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deletestockLevels"
			description: "delete stockLevels"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.stockLevels.stockLevels.collection"
			test: 		 "size(context.pipeline.stockLevels.stockLevels.collection) > 0"
			preScript: """
			{
				"id": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteStockLevels($id: ID!) {
			  deleteStockLevel(id: $id)
			}"""
			postScript: """
			{
				"result": args.deleteStockLevel
			}"""
		},
	]
}
