package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

createNestedManufacturingOrderOutput : {
    Name: "createNestedManufacturingOrderOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

createNestedManufacturingOrder : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "createNestedManufacturingOrder",
    Description: """
        Creates a nested Manufacturing Order based on the provided Manufacturing Order ID.
    """,
    Response: {Type: createNestedManufacturingOrderOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "createNestedManufacturingOrderInput",
                Fields: [
                    {Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
                ],
            },
        },
    ],
    Pipelines: [
        {
            Name:        "getManufacturingOrderData",
            Description: "Fetches the Manufacturing Order and its line items based on the provided manufacturingOrderId.",
            PreScript: """
            {
                "moId": context.args.input.manufacturingOrderId
            }
            """,
            Operation : pipeline.#GraphqlOperation & {
                Query: """
                query getManufacturingOrderData($moId: ID!) {
                    manufacturingOrder(id: $moId) {
                        id
                        name
                        status
                    }
                    mOLineItems(query: {moId: {eq: $moId}}) {
                        collection {
                            id
                            requiredQuantity
                            bomLineItem {
                                item {
                                    id
                                    name
                                    bomId
                                    quantity
                                }
                            }
                        }
                    }
                }
                """
            }
            PostHook : common.#Script & {
                Expr: """
                (() => {
                    const manufacturingOrder = args.manufacturingOrder;
                    const moLineItems = args.mOLineItems.collection;

                    if (!manufacturingOrder) {
                        return {
                            success: false,
                            message: 'Manufacturing Order not found for the provided MoId.',
                        };
                    }

                    if (manufacturingOrder.status === 'Completed') {
                        return {
                            success: false,
                            message: 'Cannot create a nested Manufacturing Order for a completed Manufacturing Order.',
                        };
                    }

                    if (moLineItems.length === 0) {
                        return {
                            success: false,
                            message: 'No Manufacturing Order Line Items found for the provided MoId.',
                        };
                    }

                    // Initialize array for missing items
                    const missingItems = [];

                    moLineItems.forEach(item => {
                        const bomId = item.bomLineItem.item.bomId;
                        const itemName = item.bomLineItem.item.name;
                        const availableQuantity = item.bomLineItem.item.quantity;
                        const requiredQuantity = item.requiredQuantity;

                        // Skip if bomId is null
                        if (!bomId) {
                            return;
                        }

                        // Only calculate remainingQuantity if requiredQuantity > availableQuantity
                        if (requiredQuantity > availableQuantity) {
                            const remainingQuantity = requiredQuantity - availableQuantity;

                            missingItems.push({
                                bomId: bomId,
                                missingQuantity: remainingQuantity,
                                itemName,
                                parentMoItem: item.id
                            });
                        }
                    });

                    if (missingItems.length === 0) {
                        return {
                            success: false,
                            message: 'All the items are sufficient in inventory; no need to create nested items.',
                        };
                    }

                    return {
                        success: true,
                        message: 'Manufacturing Order is valid and can create a nested Manufacturing Order.',
                        missingItems,
                        manufacturingOrder
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
            Name:        "createNestedMo",
            Description: "Creates nested Manufacturing Orders for each missing item.",
            ForEach:     "context.pipeline.getManufacturingOrderData.missingItems",
            Test:        "size(context.pipeline.getManufacturingOrderData.missingItems) > 0",
			PreHook : common.#Script & {
                Expr: """
                (() => {
                    return {
                        "input": {
                            "bomId": each.bomId,
                            "quantity": each.missingQuantity,
                            "name": `${each.itemName} for ${context.pipeline.getManufacturingOrderData.manufacturingOrder.name}`,
                            "parentMoId": context.args.input.manufacturingOrderId,
                            "parentMoItem": each.parentMoItem
                        }
                    };
                })()
                """
            },
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation createManufacturingOrderAndWorkOrders($input: createManufacturingInput!) {
                    createManufacturingOrderAndWorkOrders(input: $input) {
                        manufacturingOrderId
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
