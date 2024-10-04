package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

computeWorkOrderCostRealDuration: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "computeWorkOrderCostRealDuration"
	Description: """
		The purpose of this operation is to compute and update the real duration of a specific Work Order. The steps involved are as follows:
		
		1. Retrieve the total real duration of time tracked for a specific Work Order by aggregating the sum of all time tracking entries associated with the given Work Order ID.
		2. Update the Work Order's real duration by setting it to the total duration calculated from all associated time tracking entries.
	"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "ComputeWorkOrderCostRealDurationInput"
				Fields: [
					{Name: "workOrderId", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {
		Type: {
			Name: "ComputeWorkOrderCostRealDurationOutput"
			Fields: [
				{Name: "totalDuration", Type: pipeline.Float},
			]
		}
	}
	PostScript: """
	{
		"totalDuration": get(context.pipeline.fetchTotalOfRealDuration.totalDuration, 0),
	}"""
	Pipelines: [
		{
			Name:        "fetchTotalOfRealDuration"
 			Description: "Retrieves the total real duration of time tracked for a specific Work Order by aggregating the sum of all time tracking entries associated with the given Work Order ID.",
			PreScript: """
				{
					'workOrderId': context.args.input.workOrderId,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query fetchTotalOfRealDuration($workOrderId: ID!) {
						aggregateWOTimeTrackings(query: {workOrderId: {eq: $workOrderId}}) {
							sum {
								duration
							}
						}
					}"""
			}
			PostScript: """
				{
				    "totalDuration": isNull(args.aggregateWOTimeTrackings[0].sum.duration) ? 0.0 : decimal(args.aggregateWOTimeTrackings[0].sum.duration),
				}"""
		},
		{
			Name:        "updateRealDurationWorkOrder"
			Description: "Updates the real duration of a Work Order by setting it to the total duration calculated from all associated time tracking entries.",
			PreScript: """
				{
					'workOrderId': context.args.input.workOrderId,
					'totalDuration':context.pipeline.fetchTotalOfRealDuration.totalDuration
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation updateWorkOrderMutation($workOrderId:ID!,$totalDuration:Int) {
						updateWorkOrder(id: $workOrderId, input: {realDuration: $totalDuration}) {
							id
							realDuration
						}
					}
					"""
			}
		},
	]
}
