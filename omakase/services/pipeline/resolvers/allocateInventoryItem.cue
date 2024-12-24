package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

allocateInventoryItemOutput : {
    Name: "allocateInventoryItemOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
        {Name: "itemId", Type: pipeline.ID, Required: false},
    ],
}

allocateInventoryItem : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "allocateInventoryItem",
    Description: """
        Consumes a specified quantity of an inventory item.
    """,
    Response: {Type: allocateInventoryItemOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "allocateInventoryItemInput",
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
					if (item.quantity < requestedQuantity) {
						return {
							success: false,
							message: 'Insufficient quantity in inventory.'
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
                    const newQuantity = item.quantity - context.args.input.quantity;
                    const newWoallocatedQuantity = item.woAllocatedQuantity + context.args.input.quantity;
                    return {
                        "id": context.args.input.itemId,
                        "input": {
                            "quantity": newQuantity,
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