package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

moveWoToInProgressOutput : {
    Name: "moveWoToInProgressOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

moveWoToInProgress : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "moveWoToInProgress",
    Description: """
Moves a Work Order to 'in progress' status if sufficient inventory is available.
""",
    Response: {Type: moveWoToInProgressOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "moveWoToInProgressInput",
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
                    if (workOrder.status !== 'Ready') {
                        return {
                            success: false,
                            message: 'Work order status is not Ready.'
                        };
                    }
                    return {
                        success: true
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
            Description: "Fetches all work order line items.",
            PreScript: """
            {
                "workOrderId": context.args.input.workOrderId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query fetchWorkOrderLineItems($workOrderId: ID!) {
                    workOrderLineItems(query: {workOrderId: {eq: $workOrderId}}) {
                        collection {
                            workOrderId
                            scrapAction
                            quantity
                            moLineItem {
                                id
                                bomLineItem {
                                    itemId
                                }
                            }
                        }
                    }
                }
                """
            },
            PostHook: common.#Script & {
                Expr: """
                (() => {
                    const lineItems = args.workOrderLineItems.collection;
                    const itemQuantities = {};

                    if (lineItems.length === 0) {
                        return {
                            itemRequirements: []
                        };
                    }

                    lineItems.forEach(item => {
                        const itemId = item.moLineItem.bomLineItem.itemId;
                        const quantity = item.quantity;

                        if (itemQuantities[itemId]) {
                            itemQuantities[itemId] += quantity;
                        } else {
                            itemQuantities[itemId] = quantity;
                        }
                    });

                    const itemRequirements = Object.keys(itemQuantities).map(itemId => ({
                        itemId: itemId,
                        totalQuantity: itemQuantities[itemId]
                    }));

                    return {
                        itemRequirements: itemRequirements
                    };
                })()
                """
            }
        },
        {
            Name:        "validateInventory",
            Description: "Validates if required quantities are available in inventory.",
            ForEach:     "context.pipeline.fetchWorkOrderLineItems.itemRequirements",
            Test:        "size(context.pipeline.fetchWorkOrderLineItems.itemRequirements) > 0",
            PreScript: """
            {
                "itemId": each.itemId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query validateInventory($itemId: ID!) {
                    item(id: $itemId) {
                        id
                        name
                        woAllocatedQuantity
                    }
                }
                """
            },
            PostValidation: """
            args.item.woAllocatedQuantity < each.totalQuantity ?
            'Insufficient woAllocatedQuantity for item: ' + args.item.name :
            ''
            """
        },
        {
            Name:        "consumeAllocatedInventoryItems",
            Description: "Allocates inventory items.",
            ForEach:     "context.pipeline.fetchWorkOrderLineItems.itemRequirements",
            Test:        "size(context.pipeline.fetchWorkOrderLineItems.itemRequirements) > 0",
            PreScript: """
            {
                "input": {
                    "itemId": each.itemId,
                    "quantity": each.totalQuantity
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation consumeAllocatedInventoryItems($input: consumeAllocatedInventoryItemInput!) {
                    consumeAllocatedInventoryItem(input: $input) {
                        success
                        itemId
                    }
                }
                """
            },
            PostValidation: """
            !args.consumeAllocatedInventoryItem.success ?
             'Failed to allocate inventory for item: ' + each.itemId :
            ''
            """
        },
        {
            Name:        "updateWorkOrderStatus",
            Description: "Updates the work order status to 'In_Progress'.",
            PreScript: """
            {
                "id": context.args.input.workOrderId,
                "input": {
                    "status": "In_Progress"
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
