package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

consumeInventoryItemOutput : {
    Name: "consumeInventoryItemOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
        {Name: "message", Type: pipeline.String, Required: true},
    ],
}

consumeInventoryItem : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "consumeInventoryItem",
    Description: """
        Consumes a specified quantity of an inventory item.
    """,
    Response: {Type: consumeInventoryItemOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "consumeInventoryItemInput",
                Fields: [
                    {Name: "itemId", Type: pipeline.ID, Required: true},
                    {Name: "consumeQuantity", Type: pipeline.Int, Required: true},
                ],
            },
        },
    ],
    Pipelines: [
        {
            Name:        "fetchItem",
            Description: "Fetches the inventory item based on the provided itemId.",
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
                        name
                        quantity
                    }
                }
                """
            },
            PostHook: common.#Script & {
                Expr: """
                (() => {
                    const item = args.item;
                    const consumeQuantity = context.args.input.consumeQuantity;
                    if (!item) {
                        return {
                            success: false,
                            message: 'Item not found.'
                        };
                    }
                    if (consumeQuantity > item.quantity) {
                        return {
                            success: false,
                            message: 'Insufficient inventory to consume the requested quantity.'
                        };
                    }
                    const newQuantity = item.quantity - consumeQuantity;
                    return {
                        success: true,
                        newQuantity: newQuantity
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
            Name:        "updateItem",
            Description: "Updates the item's quantity in the inventory.",
            PreScript: """
            {
                "id": context.args.input.itemId,
                "input": {
                    "quantity": context.pipeline.fetchItem.newQuantity
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation updateItem($id: ID!, $input: ItemUpdateInput!) {
                    updateItem(id: $id, input: $input) {
                        quantity
                    }
                }
                """
            },
            PostHook: common.#Script & {
                Expr: """
                (() => {
                    const updatedItem = args.updateItem;
                    if (!updatedItem) {
                        return {
                            success: false,
                            message: 'Failed to update item quantity.'
                        };
                    }
                    return {
                        success: true,
                        message: 'Item quantity successfully updated.'
                    };
                })()
                """
            },
            PostValidation: """
                !context.pipeline.updateItem.success ?
                context.pipeline.updateItem.message :
                ''
            """
        }
    ],
    PostScript: """
    {
        "success": context.pipeline.updateItem.success,
        "message": context.pipeline.updateItem.message
    }
    """
}
