package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

calculateReplenishmentAlert: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "calculateReplenishmentAlert"
	description: """
	The purpose of this Pipeline is to refresh DemandForecast table by aggregating the StockEventCalc table to calculate the average demand for each product and location combination, then store the result to DemandForecast.
	This Pipeline follows the following steps:
	1. Get all the DemandForecast records. This old data will be deleted in the last step.
	2. Refresh the StockEventCalc records by running calculateStockEventCalc pipeline.
	3. Aggregate the StockEventCalc records to calculate the average demand time for each product and location.
	4. Create DemandForecast records based on the result of the aggregation.
	5. Delete the DemandForecast records created prior to the the update.
	"""
	response: { type: schema.Boolean }	
	postScript: """
	size(context.pipeline.updateReplenishmentAlert.result)>0 || size(context.pipeline.deletereplenishmentAlerts.result)>0
	"""
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "replenishmentAlerts"
			description: "Get all the stockLevels records. This old data will be deleted in the last step."
			url:         settings.services.gateway
			graphqlQuery: """
			query replenishmentAlerts{
			  replenishmentAlerts{
			    collection{
			      id
			    }
			  }
			}"""
			postScript: """
			{
				"replenishmentAlerts": args.replenishmentAlerts,
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "aggregateSupplierLeadTimes"
			description: "Get all the stockLevels records. This old data will be deleted in the last step."
			url:         settings.services.gateway
			graphqlQuery: """
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
			postScript: """
			{
				"aggregateSupplierLeadTimes": args.aggregateSupplierLeadTimes,
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "createReplenishmentAlert"
			description: "Refresh the StockEventCalc records by running calculateStockEventCalc pipeline."
			url:         settings.services.gateway
			forEach:	 "args.aggregateSupplierLeadTimes"
			preScript:   """
			{
				"input": {
					"productID": each.groupBy.productID,
					"locationID": each.groupBy.locationID,
					"maxLeadTime": each.max.averageLeadTime,
				}
			}"""
			graphqlQuery: """
			mutation ($input: ReplenishmentAlertCreateInput) {
			  createReplenishmentAlert(input: $input) {
			    id
				productID
				locationID
			  }
			}"""
			postScript: """
			{
				"result": args.createReplenishmentAlert
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "prepReplenishmentAlertCreateInput"
			description: "Fetch records based on the result of the aggregation."
			url:         settings.services.gateway
			forEach:	 "args"
			preScript: """
			{				
				"productID": each.result.productID,
				"locationID": each.result.locationID,
			}"""
			graphqlQuery: """
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
			postScript: """
			{
				"result": {
					"daysToStockout": args.stockLevels.collection == [] ? null : args.stockLevels.collection[0].daysToStockout,
					"id": args.replenishmentAlerts.collection == [] ? null : args.replenishmentAlerts.collection[0].id,
				}
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "updateReplenishmentAlert"
			description: "update replenishmentAlert records based on the result of the aggregation."
			url:         settings.services.gateway
			forEach:	 "args"
			preScript: """
			{
				"id": each.result.id,
				"daysToStockout": each.result.daysToStockout,
			}"""
			graphqlQuery: """
			mutation ($id: ID!, $daysToStockout: Float) {
			  updateReplenishmentAlert(id: $id, input: {daysToStockout: $daysToStockout}) {
			    id
				daysToStockout
			  }
			}"""
			postScript: """
			{
				"result": args.updateReplenishmentAlert
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deletereplenishmentAlerts"
			description: "delete replenishmentAlerts"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.replenishmentAlerts.replenishmentAlerts.collection"
			test: 		 "size(context.pipeline.replenishmentAlerts.replenishmentAlerts.collection) > 0"
			preScript: """
			{
				"id": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteReplenishmentAlert($id: ID!) {
			  deleteReplenishmentAlert(id: $id)
			}"""
			postScript: """
			{
				"result": args.deleteReplenishmentAlert
			}"""
		},
	]
}
