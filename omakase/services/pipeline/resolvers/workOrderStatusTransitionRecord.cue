package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

workOrderStatusTransitionRecordOutput : {
    Name: "workOrderStatusTransitionRecordOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

workOrderStatusTransitionRecord : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "workOrderStatusTransitionRecord",
    Description: """
        Records the status transition of a Work Order by calculating the time elapsed between status changes.
    """,
    Response: {Type: workOrderStatusTransitionRecordOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "workOrderStatusTransitionRecordInput",
                Fields: [
                    {Name: "workOrderId", Type: pipeline.ID, Required: true},
                    {
                        Name: "fromStatus",
                        Type: pipeline.#EnumType & {
                            Name: "workOrderStatusEnum",
                            AllowedValues: [
                                {Value: "Draft", Description: "Draft"},
                                {Value: "Waiting_for_another_WO", Description: "Waiting for another Work Order"},
                                {Value: "Waiting_for_components", Description: "Waiting for components"},
                                {Value: "Ready", Description: "Ready"},
                                {Value: "In_Progress", Description: "In Progress"},
                                {Value: "Finished", Description: "Finished"},
                                {Value: "Canceled", Description: "Canceled"},
                            ]
                        },
                        Required: true
                    },
                    {
                        Name: "toStatus",
                        Type: pipeline.#EnumType & {
                            Name: "workOrderStatusEnum",
                            AllowedValues: [
                                {Value: "Draft", Description: "Draft"},
                                {Value: "Waiting_for_another_WO", Description: "Waiting for another Work Order"},
                                {Value: "Waiting_for_components", Description: "Waiting for components"},
                                {Value: "Ready", Description: "Ready"},
                                {Value: "In_Progress", Description: "In Progress"},
                                {Value: "Finished", Description: "Finished"},
                                {Value: "Canceled", Description: "Canceled"},
                            ]
                        },
                        Required: true
                    }
                ],
            },
        },
    ],
    Pipelines: [
        {
            Name:        "getWorkOrderData",
            Description: "Fetches the Work Order and its recent status transitions based on the provided workOrderId.",
            PreScript: """
            {
                "workOrderId": context.args.input.workOrderId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query getWorkOrderData($workOrderId: ID!) {
                    workOrder(id: $workOrderId) {
                        id
                        status
                        createdAt
                    }
                    workOrderTransitions(
                        query: {workOrderId: {eq: $workOrderId}},
                        order: {field: createdAt, direction: Desc},
                        size: 2
                    ) {
                        collection {
                            createdAt
                            workOrderId
                            fromStatus
                            toStatus
                        }
                    }
                }
                """
            },
            PostHook: common.#Script & {
                Expr: """
                (() => {
                    const workOrder = args.workOrder;
                    const workOrderTransitions = args.workOrderTransitions.collection;

                    if(context.args.input.toStatus === context.args.input.fromStatus){
                        return {
                            success: false,
                            message: 'to status and from status should not be same.',
                        };
                    }

                    if (!workOrder) {
                        return {
                            success: false,
                            message: 'Work Order not found for the provided workOrderId.',
                        };
                    }

                    // Calculate minutes since the last status transition
                    let minutesSinceLastTransition = 0;
                    if (workOrderTransitions.length === 0) {
                        const createdAt = new Date(workOrder.createdAt);
                        const now = new Date();
                        minutesSinceLastTransition = Math.floor((now - createdAt) / 60000); // Convert milliseconds to minutes
                    } else {
                        const lastTransition = new Date(workOrderTransitions[0].createdAt);
                        const now = new Date();
                        minutesSinceLastTransition = Math.floor((now - lastTransition) / 60000); // Convert milliseconds to minutes
                    }

                    return {
                        success: true,
                        message: 'Work Order data fetched and minutes since last transition calculated successfully.',
                        minutesSinceLastTransition
                    };
                })()
                """
            },
            PostValidation: """
                !context.pipeline.getWorkOrderData.success ?
                context.pipeline.getWorkOrderData.message :
                ''
            """
        },
        {
            Name:        "createWorkOrderTransition",
            Description: "Creates a Work Order Status Transition record.",
            PreScript: """
            {
                "input": {
                    "workOrderId": context.args.input.workOrderId,
                    "timeInStatus": context.pipeline.getWorkOrderData.minutesSinceLastTransition,
                    "toStatus": context.args.input.toStatus,
                    "fromStatus": context.args.input.fromStatus
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation createWorkOrderTransition($input: WorkOrderTransitionCreateInput!) {
                    createWorkOrderTransition(input: $input) {
                        id
                    }
                }
                """
            },
        }
    ],
    PostScript: """
    {
        "success": context.pipeline.getWorkOrderData.success
    }
    """
}
