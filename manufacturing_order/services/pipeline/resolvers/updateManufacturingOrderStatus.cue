package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

updateManufacturingOrderStatusOutput : {
    Name: "updateManufacturingOrderStatusOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

updateManufacturingOrderStatus : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "updateManufacturingOrderStatus",
    Description: """
        Updates the status of a Manufacturing Order based on the statuses of its Work Orders.
    """,
    Response: {Type: updateManufacturingOrderStatusOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "updateManufacturingOrderStatusInput",
                Fields: [
                    {Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
                    {
						Name: "inventoryOperation"
						Type: pipeline.#EnumType & {
							Name: "inventoryOperationType"
							AllowedValues: [
								{Value: "CONSUME"},
								{Value: "IGNORE"},
							]
						}
						Required: false
					}
                ],
            },
        },
    ],
    Pipelines: [
        {
            Name:        "fetchWorkOrders",
            Description: "Fetches all work orders associated with the given manufacturing order ID.",
            PreScript: """
            {
                "moId": context.args.input.manufacturingOrderId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query fetchWorkOrders($moId: ID!) {
                    manufacturingOrder(id: $moId) {
                        bomId
                    }
                    workOrders(query: { moId: { eq: $moId } }) {
                        edges {
                            node {
                                id
                                status
                            }
                        }
                    }
                    mOLineItems(query: { moId: { eq: $moId } }) {
                        edges {
                            node {
                                id
                                requiredQuantity
                                bomLineItem {
                                    item {
                                        id
                                        quantity
                                    }
                                }
                            }
                        }
                    }
                    workOrderLineItems(query: { moId: { eq: $moId } }) {
                        edges {
                            node {
                                moLineItemId
                                quantity
                                workOrderId
                            }
                        }
                    }
                }
                """
            },
            PostHook: common.#Script & {
                Expr: """
                (() => {
                    const manufacturingOrder = args.manufacturingOrder;
                    const workOrders = args.workOrders.edges.map(edge => edge.node);
                    const mOLineItems = args.mOLineItems.edges.map(edge => edge.node);
                    const workOrderLineItems = args.workOrderLineItems.edges.map(edge => edge.node);

                    const statuses = workOrders.map(wo => wo.status);
                    const inventoryOperation = context.args.input?.inventoryOperation ?? null;

                    let wantToMovetoStatus = null;

                    if (statuses.includes('In_Progress')) {
                        wantToMovetoStatus = 'In_Progress';
                    } else if (statuses.every(status => status === 'Canceled')) {
                        wantToMovetoStatus = 'Canceled';
                    } else if (statuses.every(status => status === 'Finished')) {
                        wantToMovetoStatus = 'Completed';
                    }

                    // logic for unmapped items
                    if (mOLineItems.length === 0) {
                        return {
                            success: false,
                            valid: false,
                            message: 'No Manufacturing Order Line Items found for the given moId.',
                        };
                    }

                    // Create a map of moLineItemId to { requiredQuantity, itemId, name, inventoryQuantity }
                    const moLineItemMap = {};
                    mOLineItems.forEach(item => {
                        moLineItemMap[item.id] = {
                            requiredQuantity: item.requiredQuantity,
                            itemId: item.bomLineItem.item.id,
                            name: item.bomLineItem.item.name,
                            inventoryQuantity: item.bomLineItem.item.quantity,
                        };
                    });

                    // Aggregate quantities used in workOrderLineItems
                    workOrderLineItems.forEach(woItem => {
                        if (moLineItemMap[woItem.moLineItemId]) {
                            moLineItemMap[woItem.moLineItemId].usedQuantity = 
                                (moLineItemMap[woItem.moLineItemId].usedQuantity || 0) + woItem.quantity;
                        }
                    });

                    // Identify unmapped items and check inventory
                    const unmappedItems = [];
                    const insufficientItems = [];
                    for (const [moLineItemId, details] of Object.entries(moLineItemMap)) {
                        const usedQty = details.usedQuantity || 0;
                        const unmappedQty = details.requiredQuantity - usedQty;

                        if (unmappedQty > 0) {
                            unmappedItems.push({
                                itemId: details.itemId,
                                unmappedQuantity: unmappedQty
                            });

                            if (details.inventoryQuantity < unmappedQty) {
                                insufficientItems.push({
                                    itemId: details.itemId,
                                    unmappedQuantity: unmappedQty
                                });
                            }
                        }
                    }

                    if (insufficientItems.length > 0) {
                        return {
                            success: true,
                            valid: false,
                            message: 'Some BOM Line Items have insufficient inventory for unmapped quantities.',
                            unmappedItems: unmappedItems,
                            insufficientItems: insufficientItems,
                            workOrders,
                            wantToMovetoStatus,
                        };
                    }

                    if (unmappedItems.length > 0) {
                        return {
                            success: true,
                            valid: false,
                            message: 'Some of the items are not mapped with work orders',
                            unmappedItems: unmappedItems,
                            insufficientItems: insufficientItems,
                            workOrders,
                            wantToMovetoStatus,
                        };
                    }

                    return {
                        success: true,
                        valid: true,
                        message: null,
                        mOLineItems: mOLineItems,
                        workOrderLineItems: workOrderLineItems,
                        unmappedItems: [],
                        insufficientItems: [],
                        workOrders,
                        wantToMovetoStatus,
                    };
                })()
                """
            },
            PostValidation: """
                !context.pipeline.fetchWorkOrders.success ?
                context.pipeline.fetchWorkOrders.message :
                ''
            """
        },
        {
            Name:        "validateInventoryItemsWhenConsume",
            Description: "Fetches all work orders associated with the given manufacturing order ID.",
            Test:        "size(context.pipeline.fetchWorkOrders.unmappedItems) > 0 && get(context.args.input.inventoryOperation, null) == 'CONSUME'",
            PostHook: common.#Script & {
                Expr: """
                (() => {
                    const insufficientItems = context.pipeline.fetchWorkOrders.insufficientItems;
                    
                    if (insufficientItems.length > 0) {
                        return {
                            success: false,
                            message: "Can't consume, insufficient inventory",
                        };
                    }

                    return {
                        success: true,
                        message: null
                    };
                })()
                """
            },
            PostValidation: """
                !context.pipeline.validateInventoryItemsWhenConsume.success ?
                context.pipeline.validateInventoryItemsWhenConsume.message :
                ''
            """
        },
        {
            Name:        "consumeItem",
            Description: "Consumes unmapped BOM Line Items from inventory when there are unmapped items and no insufficient inventory.",
            ForEach:     "context.pipeline.fetchWorkOrders.unmappedItems",
            Test:        "size(context.pipeline.fetchWorkOrders.unmappedItems) > 0 && get(context.args.input.inventoryOperation, null) == 'CONSUME' && context.pipeline.validateInventoryItemsWhenConsume.success",
            PreScript: """
            {
                "input":{
                    "itemId": each.itemId,
                    "consumeQuantity": each.unmappedQuantity
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation consumeItem($input: consumeInventoryItemInput!) {
                    consumeInventoryItem(input: $input) {
                        message
                        success
                    }
                }
                """
            },
            PostHook: common.#Script & {
                Expr: """
                (() => {
                    const result = args.consumeInventoryItem;
                    if (!result.success) {
                        return {
                            success: false,
                            message: 'Failed to consume inventory for itemId: ' + each.itemId
                        };
                    }
                    return {
                        success: true
                    };
                })()
                """
            },
            PostValidation: """
                !args.success ?
                args.message :
                ''
            """
        },
        {
            Name:        "updateManufacturingOrderStatus",
            Description: "Updates the Manufacturing Order status based on the statuses of associated work orders.",
            PreHook: common.#Script & {
                Expr: """
                (() => {
                    const wantToMovetoStatus = context.pipeline.fetchWorkOrders.wantToMovetoStatus;
                    const message = context.pipeline.fetchWorkOrders.message;
                    const valid = context.pipeline.fetchWorkOrders.valid;
                    const validateInventoryItemsWhenConsume = context.pipeline?.validateInventoryItemsWhenConsume?.success ?? null;
                    const inventoryOperation = context.args.input?.inventoryOperation ?? null;

                    if(wantToMovetoStatus == 'Canceled' || wantToMovetoStatus === 'In_Progress'){
                        return {
                            "id": context.args.input.manufacturingOrderId,
                            "input": {
                                "status": wantToMovetoStatus,
                            },
                            wantToMovetoStatus
                        };
                    }else if(wantToMovetoStatus === 'Completed' && inventoryOperation === null && !valid){
                        return {
                            "id": context.args.input.manufacturingOrderId,
                            "input": {
                                "errorMessage": message,
                            },
                            wantToMovetoStatus
                        };
                    }else if(wantToMovetoStatus === 'Completed' && inventoryOperation === 'IGNORE' && !valid){
                        return {
                            "id": context.args.input.manufacturingOrderId,
                            "input": {
                                "status": wantToMovetoStatus,
                                "errorMessage": "Ignored the operation line items validation and completed",
                            },
                            wantToMovetoStatus
                        };
                    }else if(inventoryOperation == null && wantToMovetoStatus == 'Completed' && valid){
                        return {
                            "id": context.args.input.manufacturingOrderId,
                            "input": {
                                "status": wantToMovetoStatus,
                            },
                            wantToMovetoStatus
                        };
                    }else if(inventoryOperation == 'CONSUME' && validateInventoryItemsWhenConsume && wantToMovetoStatus == 'Completed'){
                        return {
                                "id": context.args.input.manufacturingOrderId,
                               "input": {
                                    "status": wantToMovetoStatus,
                                    "errorMessage":null,
                                },
                                wantToMovetoStatus
                        };
                    }else{
                        return {
                            "id": context.args.input.manufacturingOrderId,
                            "input": {},
                            wantToMovetoStatus
                        };
                    }
                })()
                """
            },
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation updateManufacturingOrderStatus($id: ID!, $input: ManufacturingOrderUpdateInput!) {
                    updateManufacturingOrder(id: $id, input: $input) {
                        id
                        status
                        itemId
                        quantity
                    }
                }
                """
            },
            PostScript: """
            {
                "success": true,
                "manufacturingOrder": args.updateManufacturingOrder
            }
            """
        },
        {
			Name:        "addProduceItemToInventory",
			Description: "Add produce item to inventory item when the manufacturing order is completed.",
			Test:        "context.pipeline.updateManufacturingOrderStatus.manufacturingOrder.status == 'Completed'",
			PreScript: """
			{
				"input": {
					"itemId": context.pipeline.updateManufacturingOrderStatus.manufacturingOrder.itemId,
					"quantity": context.pipeline.updateManufacturingOrderStatus.manufacturingOrder.quantity,
					"scrapAction": "Return"
				}
			}
			""",
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation addProduceItemToInventory($input: scrapConsumedInventoryItemInput!) {
					scrapConsumedInventoryItem(input: $input) {
						success
					}
				}
				"""
			},
		}
    ],
    PostScript: """
    {
        "success": true
    }
    """
}
