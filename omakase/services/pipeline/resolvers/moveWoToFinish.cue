package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

moveWoToFinishOutput : {
    Name: "moveWoToFinishOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

moveWoToFinish : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "moveWoToFinish",
	Description: """
		Moves a Work Order to 'Finished' status if all dependent work orders are finished
	"""
    Response: {Type: moveWoToFinishOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "moveWoToFinishInput",
                Fields: [
                    {Name: "workOrderId", Type: pipeline.ID, Required: true},
                ],
            },
        },
    ],
    Pipelines: [
        {
            Name:        "fetchWorkOrder",
            Description: "Fetches the work order by ID.",
            PreScript: """
			{
				"workOrderId": context.args.input.workOrderId
			}
			""",
            Operation: pipeline.#GraphqlOperation & {
                Query: """
				query fetchWorkOrder($workOrderId: ID!) {
					workOrder(id: $workOrderId) {
						id
						status
					}
				}
				"""
            },
            PostHook: common.#Script & {
                Expr: """
					(() => {
					const workOrder = args.workOrder;

					if (!workOrder || !workOrder.id) {
						return {
							success: false,
							message: 'Work order not found.'
						};
					}
					if (workOrder.status !== 'In_Progress') {
						return {
							success: false,
							message: 'Work order status is not In Progress.'
						};
					}
					return {
						success: true,
						workOrder: workOrder
					};
					})()
					"""
            },
            PostValidation: """
				!context.pipeline.fetchWorkOrder.success ?
				context.pipeline.fetchWorkOrder.message :
				''
			"""
        },
        {
            Name:        "updateWorkOrderStatus",
            Description: "Updates the work order status to 'Finished'.",
            PreScript: """
				{
					"id": context.args.input.workOrderId,
					"input": {
						"status": "Finished"
					}
				}
			""",
            Operation: pipeline.#GraphqlOperation & {
                Query: """
					mutation updateWorkOrderStatus($id: ID!, $input: WorkOrderUpdateInput!) {
						updateWorkOrder(id: $id, input: $input) {
							id
							status
						}
					}
				"""
            }
        },
    ],
    PostScript: """
		{
			"success": true
		}
	"""
}
