package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

// Todo change name to consume
consumeAllocatedInventoryItemOutput : {
    Name: "consumeAllocatedInventoryItemOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
        {Name: "itemId", Type: pipeline.ID, Required: false},
    ],
}

consumeAllocatedInventoryItem : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "consumeAllocatedInventoryItem",
    Description: """
        Consumes a specified allocatedQuantity of an inventory item.
    """,
    Response: {Type: consumeAllocatedInventoryItemOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "consumeAllocatedInventoryItemInput",
                Fields: [
                    {Name: "itemId", Type: pipeline.ID, Required: true},
                    {Name: "quantity", Type: pipeline.Int, Required: true},
                ],
            },
        },
    ],
    Pipelines: [
        {
            Name:        "fetchItem",
            Description: "Fetches the item by itemId.",
            PreScript: """
            {
                "itemId": context.args.input.itemId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query fetchItem($itemId: ID!) {
                    item(id: $itemId) {
                        id
                        description
                        name
                        quantity
                        woAllocatedQuantity
                        scrapAction
                        sku
                        returnAsNewSkuItemId
                        inventoryType
                        bomId
                    }
                }
                """
            },
            PostHook : common.#Script & {
				Expr: """
				(() => {
					const item = args.item;
					const requestedQuantity = context.args.input.quantity;

					if (!item?.id) {
						return {
							success: false,
							message: 'Item not found.'
						};
					}
					if (item?.woAllocatedQuantity < requestedQuantity) {
						return {
							success: false,
							message: 'Insufficient woAllocatedQuantity.'
						};
					}
					return {
						success: true,
						item
					};
				})()
				"""
			},
            PostValidation: """
                !context.pipeline.fetchItem.success ?
                context.pipeline.fetchItem.message :
                ''
            """
        },
        {
            Name:        "updateItemQuantity",
            Description: "Updates the item's quantity by subtracting the consumed amount.",
			Test:        "context.pipeline.fetchItem.success"
            PreHook: common.#Script & {
                Expr: """
                (() => {
                    const item = context.pipeline.fetchItem.item;
                    const newWoallocatedQuantity = item.woAllocatedQuantity - context.args.input.quantity;
                    return {
                        "id": context.args.input.itemId,
                        "input": {
                            "woAllocatedQuantity": newWoallocatedQuantity
                        }
                    };
                })()
                """
            },
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation updateItemQuantity($id: ID!, $input: ItemUpdateInput!) {
                    updateItem(id: $id, input: $input) {
                        id
                        quantity
                        woAllocatedQuantity
                    }
                }
                """
            },
            PostScript: """
            {
                "updatedItem": args.updateItem
            }
            """
        }
    ],
    PostScript: """
    {
        "success": context.pipeline.fetchItem.success,
        "itemId": context.args.input.itemId,
    }
    """
}
