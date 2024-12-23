package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

cancelWorkOrderOutput : {
    Name: "cancelWorkOrderOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

cancelWorkOrder : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "cancelWorkOrder",
    Description: """
        Cancels a Work Order and handles inventory adjustments based on its status.
    """,
    Response: {Type: cancelWorkOrderOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "cancelWorkOrderInput",
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

                    if (!workOrder || !workOrder?.id) {
                        return {
                            success: false,
                            message: 'Work order not found.'
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
            Name:        "fetchWorkOrderLineItems",
            Description: "Fetches all work order line items for the given work order ID.",
            PreScript: """
            {
                "workOrderId": context.args.input.workOrderId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query fetchWorkOrderLineItems($workOrderId: ID!) {
                    workOrderLineItems(query: {workOrderId: {eq: $workOrderId}}) {
                        edges {
                            node {
                                quantity
                                returnAsNewSkuItemId
                                scrapAction
                                moLineItem {
                                    bomLineItem {
                                        itemId
                                    }
                                }
                            } 
                        }
                    }
                }
                """
            },
            PostScript: """
            {
                "lineItems": args.workOrderLineItems.edges.map(edge, edge.node)
            }
            """
        },
        {
            Name:        "removeAllocatedInventoryItems",
            Description: "Removes allocated inventory items for each work order line item if status is Ready.",
            ForEach:     "context.pipeline.fetchWorkOrderLineItems.lineItems",
            Test:        "context.pipeline.fetchWorkOrder.workOrder.status == 'Ready'",
            PreScript: """
            {
                "input": {
                    "itemId": each.moLineItem.bomLineItem.itemId,
                    "quantity": each.quantity
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation removeAllocatedInventoryItems($input: removeAllocatedInventoryItemInput!) {
                    removeAllocatedInventoryItem(input: $input) {
                        success
                    }
                }
                """
            },
            PostValidation: """
                !args.removeAllocatedInventoryItem.success ?
                'Failed to remove allocated inventory for item: ' + each.moLineItem.bomLineItem.itemId :
                ''
            """
        },
        {
            Name:        "scrapConsumedInventoryItems",
            Description: "Scraps consumed inventory items for each work order line item if status is In_Progress.",
            ForEach:     "context.pipeline.fetchWorkOrderLineItems.lineItems",
            Test:        "context.pipeline.fetchWorkOrder.workOrder.status == 'In_Progress'",
            PreScript: """
            {
                "input": {
                    "itemId": each.moLineItem.bomLineItem.itemId,
                    "quantity": each.quantity,
                    "scrapAction": each.scrapAction,
                    "returnAsNewSkuItemId": each.returnAsNewSkuItemId
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation scrapConsumedInventoryItems($input: scrapConsumedInventoryItemInput!) {
                    scrapConsumedInventoryItem(input: $input) {
                        success
                    }
                }
                """
            },
            PostValidation: """
                !args.scrapConsumedInventoryItem.success ?
                'Failed to scrap consumed inventory for item: ' + each.moLineItem.bomLineItem.itemId :
                ''
            """
        },
        {
            Name:        "updateWorkOrderStatus",
            Description: "Updates the work order status to 'Canceled'.",
            PreScript: """
            {
                "id": context.args.input.workOrderId,
                "input": {
                    "status": "Canceled",
                    "startDate":null,
                    "endDate":null
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation updateWorkOrderStatus($id: ID!, $input: WorkOrderUpdateInput!) {
                    updateWorkOrder(id: $id, input: $input) {
                        id
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
