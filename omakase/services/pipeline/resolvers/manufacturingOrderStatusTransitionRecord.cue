package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

manufacturingOrderStatusTransitionRecordOutput : {
    Name: "manufacturingOrderStatusTransitionRecordOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

manufacturingOrderStatusTransitionRecord : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "manufacturingOrderStatusTransitionRecord",
    Description: """
        Records the status transition of a Manufacturing Order by calculating the time elapsed between status changes.
    """,
    Response: {Type: manufacturingOrderStatusTransitionRecordOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "manufacturingOrderStatusTransitionRecordInput",
                Fields: [
                    {Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
                    {
                        Name: "fromStatus",
                        Type: pipeline.#EnumType & {
                            Name: "manufacturingOrderStatusEnum",
                            AllowedValues: [
                                {Value: "Draft", Description: "Draft"},
                                {Value: "Planned", Description: "Planned"},
                                {Value: "In_Progress", Description: "In Progress"},
                                {Value: "Completed", Description: "Completed"},
                                {Value: "Canceled", Description: "Canceled"},
                            ]
                        },
                        Required: true
                    },
                    {
                        Name: "toStatus",
                        Type: pipeline.#EnumType & {
                            Name: "manufacturingOrderStatusEnum",
                            AllowedValues: [
                                {Value: "Draft", Description: "Draft"},
                                {Value: "Planned", Description: "Planned"},
                                {Value: "In_Progress", Description: "In Progress"},
                                {Value: "Completed", Description: "Completed"},
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
            Name:        "getManufacturingOrderData",
            Description: "Fetches the Work Order and its recent status transitions based on the provided manufacturingOrderId.",
            PreScript: """
            {
                "manufacturingOrderId": context.args.input.manufacturingOrderId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query getManufacturingOrderData($manufacturingOrderId: ID!) {
                    manufacturingOrder(id: $manufacturingOrderId) {
                        id
                        status
                        createdAt
                    }
                    manufacturingOrderTransitions(
                        query: {moId: {eq: $manufacturingOrderId}},
                        order: {field: createdAt, direction: Desc},
                        size: 2
                    ) {
                        collection {
                            createdAt
                            moId
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
                    const manufacturingOrder = args.manufacturingOrder;
                    const manufacturingOrderTransitions = args.manufacturingOrderTransitions.collection;

                    if(context.args.input.toStatus === context.args.input.fromStatus){
                        return {
                            success: false,
                            message: 'to status and from status should not be same.',
                        };
                    }

                    if (!manufacturingOrder) {
                        return {
                            success: false,
                            message: 'Manufacturing Order not found for the provided manufacturingOrderId.',
                        };
                    }

                    // Calculate minutes since the last status transition
                    let minutesSinceLastTransition = 0;
                    if (manufacturingOrderTransitions.length === 0) {
                        const createdAt = new Date(manufacturingOrder.createdAt);
                        const now = new Date();
                        minutesSinceLastTransition = Math.floor((now - createdAt) / 60000); // Convert milliseconds to minutes
                    } else {
                        const lastTransition = new Date(manufacturingOrderTransitions[0].createdAt);
                        const now = new Date();
                        minutesSinceLastTransition = Math.floor((now - lastTransition) / 60000); // Convert milliseconds to minutes
                    }

                    return {
                        success: true,
                        message: 'Manufacturing Order data fetched and minutes since last transition calculated successfully.',
                        minutesSinceLastTransition
                    };
                })()
                """
            },
            PostValidation: """
                !context.pipeline.getManufacturingOrderData.success ?
                context.pipeline.getManufacturingOrderData.message :
                ''
            """
        },
        {
            Name:        "createManufacturingOrderTransition",
            Description: "Creates a Work Order Status Transition record.",
            PreScript: """
            {
                "input": {
                    "moId": context.args.input.manufacturingOrderId,
                    "timeInStatus": context.pipeline.getManufacturingOrderData.minutesSinceLastTransition,
                    "toStatus": context.args.input.toStatus,
                    "fromStatus": context.args.input.fromStatus
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation createManufacturingOrderTransition($input: ManufacturingOrderTransitionCreateInput!) {
                    createManufacturingOrderTransition(input: $input) {
                        id
                    }
                }
                """
            },
        }
    ],
    PostScript: """
    {
        "success": context.pipeline.getManufacturingOrderData.success
    }
    """
}
