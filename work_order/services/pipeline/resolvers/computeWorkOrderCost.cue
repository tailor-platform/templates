package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

computeWorkOrderCost: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "computeWorkOrderCost"
	Description:   "Computes the total cost of a work order based on the hourly employee rate and the number of hours worked on the work center."
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
				{Name: "costPerEmployee", Type: pipeline.Float},
				{Name: "hourlyProcessingCost", Type: pipeline.Float},
			]
		}
	}
	PostScript: """
	{
		"totalCost": (context.pipeline.fetchWorkOrderAndWorkLog.costPerEmployee + context.pipeline.fetchWorkOrderAndWorkLog.hourlyProcessingCost) * context.pipeline.fetchWorkOrderAndWorkLog.totalDuration / 60.0,
		"totalDuration": context.pipeline.fetchWorkOrderAndWorkLog.totalDuration,
		"costPerEmployee": context.pipeline.fetchWorkOrderAndWorkLog.costPerEmployee,
		"hourlyProcessingCost": context.pipeline.fetchWorkOrderAndWorkLog.hourlyProcessingCost
	}"""
	Pipelines: [
		{
			Name:        "fetchWorkOrderAndWorkLog"
			Description: "Fetch the Work Order details"
			PreScript: """
				{
					'workOrderId': context.args.input.workOrderId,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query fetchWorkOrderAndWorkLog($workOrderId: ID!) {
						workOrder(id: $workOrderId) {
							id
							workCenter {
								code
								costPerEmployee
								hourlyProcessingCost
							}
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
					"costPerEmployee": get(args.workOrder.workCenter.costPerEmployee, 0),
					"hourlyProcessingCost": get(args.workOrder.workCenter.hourlyProcessingCost, 0),
					"totalDuration": get(args.aggregateWOTimeTrackings[0].sum.duration, 0)
				}"""
			PostValidation: """
				context.pipeline.fetchWorkOrderAndWorkLog.workOrder == null ?
					'Invalid work order ID' :
					''
			"""
		},
	]
}
