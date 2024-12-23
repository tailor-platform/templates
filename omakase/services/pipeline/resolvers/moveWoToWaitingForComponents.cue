package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

moveWoToWaitingForComponentsOutput : {
    Name: "moveWoToWaitingForComponentsOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

moveWoToWaitingForComponents : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "moveWoToWaitingForComponents",
	Description: """
		Moves a Work Order to 'Waiting_for_components' status if all dependent work orders are finished
	"""
    Response: {Type: moveWoToWaitingForComponentsOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "moveWoToWaitingForComponentsInput",
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
					if (workOrder.status !== 'Waiting_for_another_WO') {
						return {
							success: false,
							message: 'Work order status is not Waiting for another WO.'
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
            Name:        "fetchWorkOrderDependencies",
            Description: "Fetches all dependent work orders with status.",
            PreScript: """
			{
				"workOrderId": context.args.input.workOrderId
			}
			""",
            Operation: pipeline.#GraphqlOperation & {
                Query: """
				query fetchWorkOrderDependencies($workOrderId: ID!) {
					workOrderDependencies(query: {workOrderId: {eq: $workOrderId}}) {
						collection {
							dependsOnWorkOrder {
								status
							}
						}
					}
				}
				"""
            },
            PostHook: common.#Script & {
                Expr: """
				(() => {
					const dependencies = args.workOrderDependencies.collection;

					if (dependencies.length === 0) {
						return {
							success: true
						};
					}

					const allFinished = dependencies.every(dep => dep.dependsOnWorkOrder.status === 'Finished');

					if (!allFinished) {
						return {
							success: false,
							message: 'Dependent work orders are not finished yet.'
						};
					}

					return {
						success: true,
						dependencies: dependencies
					};
				})()
				"""
            },
            PostValidation: """
				!context.pipeline.fetchWorkOrderDependencies.success ?
				context.pipeline.fetchWorkOrderDependencies.message :
				''
			"""
        },
        {
            Name:        "updateWorkOrderStatus",
            Description: "Updates the work order status to 'Waiting_for_components'.",
            PreScript: """
				{
					"id": context.args.input.workOrderId,
					"input": {
						"status": "Waiting_for_components"
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
        }
    ],
    PostScript: """
		{
			"success": true
		}
	"""
}
