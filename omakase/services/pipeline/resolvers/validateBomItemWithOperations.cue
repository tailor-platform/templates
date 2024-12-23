package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

validateBomItemWithOperationsOutput : {
    Name: "validateBomItemWithOperationsOutput",
    Fields: [
        {Name: "isValid", Type: pipeline.Boolean, Required: true},
        {Name: "message", Type: pipeline.String, Required: true},
        {Name: "success", Type: pipeline.Boolean, Required: true},
        {
			Name:  "unmappedItems"
			Array: true
			Type: {
				Name: "unmappedItemsList"
				Fields: [
					{Name: "bomLineItemId", Type: pipeline.ID},
					{Name: "remainingQuantity", Type: pipeline.Int},
				]
			}
		},
    ],
}

validateBomItemWithOperations : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "validateBomItemWithOperations",
    Description: """
    Validates BOM items against their associated operations to ensure consistency and integrity.
    """,
    Response: {Type: validateBomItemWithOperationsOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "validateBomItemWithOperationsInput",
                Fields: [
                    {Name: "bomId", Type: pipeline.ID, Required: true},
                ],
            },
        },
    ],
    Pipelines: [
        {
            Name:        "fetchBomData",
            Description: "Fetches BOM line items, operations, and operation line items based on the provided bomId.",
            PreScript: """
            {
                "bomId": context.args.input.bomId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query fetchBomData($bomId: ID!) {
                    bomLineItems(query: {bomId: {eq: $bomId}}) {
                        collection {
                            id
                            inputQuantity
                            itemId
                        }
                    }
                    operationLineItems(query: {bomId: {eq: $bomId}}) {
                        collection {
                            id
                            bomLineItemId
                            bomLineItem {
                                itemId
                            }
                            operationId
                            quantity
                        }
                    }
                    operations(query: {bomId: {eq: $bomId}}) {
                        collection {
                            id
                            name
                            duration
                        }
                    }
                }
                """
            },
            PostHook: common.#Script & {
                Expr: """
                (() => {
                    const bomLineItems = args.bomLineItems.collection;
                    const operationLineItems = args.operationLineItems.collection;
                    const operations = args.operations.collection;

                    if (bomLineItems.length === 0 && operations.length === 0) {
                        return {
                            success: false,
                            isValid: false,
                            message: 'Before validate add items and operations.',
                        };
                    }

                    if ((bomLineItems.length > 0 && operations.length === 0) || operationLineItems.length === 0) {
                        return {
                            success: false,
                            isValid: false,
                            message: 'Before validate add operations and link it with items'
                        };
                    }

                    // Ensure that all bomLineItems are mapped in operationLineItems
                    let isValid = true;
                    let message = 'All BOM Line Items are properly mapped with operations.';
                    
                    const bomLineItemMap = {};
                    bomLineItems.forEach(item => {
                        bomLineItemMap[item.id] = item.inputQuantity;
                    });

                    operationLineItems.forEach(opItem => {
                        if (bomLineItemMap[opItem.bomLineItemId] !== undefined) {
                            bomLineItemMap[opItem.bomLineItemId] -= opItem.quantity;
                        }
                    });

                    const unmappedItems = [];
                    for (const [bomLineItemId, remainingQuantity] of Object.entries(bomLineItemMap)) {
                        if (remainingQuantity > 0) {
                            unmappedItems.push({ bomLineItemId, remainingQuantity });
                            isValid = false;
                        }
                    }

                    if (unmappedItems.length > 0) {
                        message = 'Some BOM Line Items are not fully mapped with operations';
                        isValid = false;
                    }

                    return {
                        success: true,
                        isValid: isValid,
                        message: message,
                        bomLineItems: bomLineItems,
                        operations: operations,
                        operationLineItems: operationLineItems,
                        unmappedItems
                    };
                })()
                """
            },
            PostValidation: """
                !context.pipeline.fetchBomData.success ?
                context.pipeline.fetchBomData.message :
                ''
            """
        },
        {
            Name:        "updateBom",
            Description: "Updates the BOM with configuration status and message.",
            Test:        "context.pipeline.fetchBomData.success",
            PreScript: """
            {
                "id": context.args.input.bomId,
                "input": {
                    "isConfiguredProperly": context.pipeline.fetchBomData.isValid,
                    "configureMessage": context.pipeline.fetchBomData.message
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation updateBom($id: ID!, $input: BomUpdateInput!) {
                    updateBom(id: $id, input: $input) {
                        id
                    }
                }
                """
            },
        },
    ],
    PostScript: """
    {
        "isValid": context.pipeline.fetchBomData.isValid,
        "message": context.pipeline.fetchBomData.message,
        "success": context.pipeline.fetchBomData.success,
        "unmappedItems": context.pipeline.fetchBomData.unmappedItems
    }
    """
}
