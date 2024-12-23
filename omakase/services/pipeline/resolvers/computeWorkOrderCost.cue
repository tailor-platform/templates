package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

computeWorkOrderCost: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "computeWorkOrderCost"
	Description: """
		The purpose of this operation is to compute the cost of a specific Work Order. The steps involved are as follows:
		
		1. Fetch the Work Order details required for cost calculation.
	"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "ComputeWorkOrderCostInput"
				Fields: [
					{Name: "workOrderId", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {
		Type: {
			Name: "ComputeWorkOrderCostOutput"
			Fields: [
				{Name: "totalCost", Type: pipeline.Float},
				{Name: "totalDuration", Type: pipeline.Float},
				{Name: "totalExpectedCost", Type: pipeline.Float},
				{Name: "totalExpectedDuration", Type: pipeline.Float},
				{Name: "costPerEmployee", Type: pipeline.Float},
				{Name: "hourlyProcessingCost", Type: pipeline.Float},
			]
		}
	}
	PostScript: """
	{
		"totalCost": (context.pipeline.fetchWorkOrderAndWorkLog.costPerEmployee + context.pipeline.fetchWorkOrderAndWorkLog.hourlyProcessingCost) * get(context.pipeline.fetchWorkOrderAndWorkLog.totalDuration, 0) / 60.0,
		"totalDuration": context.pipeline.fetchWorkOrderAndWorkLog.totalDuration,
		"totalExpectedDuration": context.pipeline.fetchWorkOrderAndWorkLog.expectedDuration,
		"totalExpectedCost": (context.pipeline.fetchWorkOrderAndWorkLog.costPerEmployee + context.pipeline.fetchWorkOrderAndWorkLog.hourlyProcessingCost) * get(context.pipeline.fetchWorkOrderAndWorkLog.expectedDuration, 0) / 60.0,
		"costPerEmployee": context.pipeline.fetchWorkOrderAndWorkLog.costPerEmployee,
		"hourlyProcessingCost": context.pipeline.fetchWorkOrderAndWorkLog.hourlyProcessingCost
	}"""
	Pipelines: [
		{
			Name:        "fetchWorkOrderAndWorkLog"
			Description: "Fetch the Work Order details for cost calculation"
			PreScript: """
				{
					'workOrderId': context.args.input.workOrderId,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query fetchWorkOrderAndWorkLog($workOrderId: ID!) {
						workOrder(id: $workOrderId) {
							id
							operation {
								workCenter {
									code
									costPerEmployee
									hourlyProcessingCost
								}
							}
							expectedDuration
						}

						aggregateWOTimeTrackings(query: {workOrderId: {eq: $workOrderId}}) {
							sum {
								duration
							}
						}
					}"""
			}
			PostScript: """
				{
					"workOrder": args.workOrder,
					"costPerEmployee": get(args.workOrder.operation.workCenter.costPerEmployee, 0),
					"hourlyProcessingCost": get(args.workOrder.operation.workCenter.hourlyProcessingCost, 0),
				    "totalDuration": isNull(args.aggregateWOTimeTrackings[0].sum.duration) ? 0.0 : decimal(args.aggregateWOTimeTrackings[0].sum.duration),
					"expectedDuration":get(args.workOrder.expectedDuration, 0)
				}"""
			PostValidation: """
				context.pipeline.fetchWorkOrderAndWorkLog.workOrder == null ?
					'Invalid work order ID' :
					''
			"""
		},
	]
}
