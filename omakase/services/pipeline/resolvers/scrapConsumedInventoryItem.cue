package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

scrapConsumedInventoryItemOutput : {
    Name: "scrapConsumedInventoryItemOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

scrapConsumedInventoryItem : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "scrapConsumedInventoryItem",
    Description: """
        Scraps a consumed or allocated inventory item.
    """,
    Response: {Type: scrapConsumedInventoryItemOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "scrapConsumedInventoryItemInput",
                Fields: [
                    {Name: "itemId", Type: pipeline.ID, Required: true},
                    {Name: "quantity", Type: pipeline.Int, Required: true},
                    {
                        Name: "scrapAction",
                        Type: pipeline.#EnumType & {
                            Name: "scrapActionType",
                            AllowedValues: [
                                { Value: "Return" },
                                { Value: "Waste" },
                                { Value: "Return_as_new_SKU" }
                            ]
                        },
                        Required: true
                    },
                    {Name: "returnAsNewSkuItemId", Type: pipeline.ID}
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
							wastedQuantity
						}
					}
				"""
            },
            PostHook: common.#Script & {
                Expr: """
					(() => {
						const item = args.item;
						const requestedQuantity = context.args.input.quantity;
						const scrapAction = context.args.input.scrapAction;
						const returnAsNewSkuItemId = context.args.input?.returnAsNewSkuItemId ?? null;

						if (!item || !item?.id) {
							return {
								success: false,
								message: 'Item not found.'
							};
						}
						if (scrapAction === 'Return_as_new_SKU' && !returnAsNewSkuItemId) {
							return {
								success: false,
								message: 'returnAsNewSkuItemId is required when scrapAction is Return_as_new_SKU.'
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
            Name:        "fetchReturnAsNewSkuItem",
            Description: "Fetches the item specified by returnAsNewSkuItemId.",
            Test:        "!isNull(context.args.input.returnAsNewSkuItemId)",
            PreScript: """
			{
				"itemId": get(context.args.input.returnAsNewSkuItemId, null) 
			}
			""",
            Operation: pipeline.#GraphqlOperation & {
                Query: """
					query fetchReturnAsNewSkuItem($itemId: ID!) {
						item(id: $itemId) {
							id
							description
							name
							quantity
							woAllocatedQuantity
							wastedQuantity
						}
					}
				"""
            },
            PostHook: common.#Script & {
                Expr: """
					(() => {
						const item = args.item;

						if (!item || !item.id) {
							return {
								success: false,
								message: 'Return as New SKU Item not found.'
							};
						}
						return {
							success: true,
							returnAsNewSkuItem: item
						};
					})()
				"""
            },
            PostValidation: """
				!context.pipeline.fetchReturnAsNewSkuItem.success ?
				context.pipeline.fetchReturnAsNewSkuItem.message :
				''
			"""
        },
        {
            Name:        "updateItem",
            Description: "Updates the item based on the scrap action.",
            PreHook: common.#Script & {
                Expr: """
                    (() => {
                        const scrapAction = context.args.input.scrapAction;
                        const inputQuantity = context.args.input.quantity;
                        let itemId;
                        const input = {};

                        if (scrapAction === 'Waste') {
                            const item = context.pipeline.fetchItem.item;
                            itemId = item.id;
                            input.wastedQuantity = (item.wastedQuantity || 0) + inputQuantity;
                        } else if (scrapAction === 'Return') {
                            const item = context.pipeline.fetchItem.item;
                            itemId = item.id;
                            input.quantity = (item.quantity || 0) + inputQuantity;
                        } else if (scrapAction === 'Return_as_new_SKU') {
                            const item = context.pipeline.fetchReturnAsNewSkuItem?.returnAsNewSkuItem;
                            itemId = item.id;
                            input.quantity = (item.quantity || 0) + inputQuantity;
                        }

                        return {
                            id: itemId,
                            input: input
                        };
                    })()
            """
            },
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation updateItem($id: ID!, $input: ItemUpdateInput!) {
                    updateItem(id: $id, input: $input) {
                        id
                        quantity
                        wastedQuantity
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
