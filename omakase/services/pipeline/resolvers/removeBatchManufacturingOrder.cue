package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

removeBatchManufacturingOrderOutput : {
    Name: "removeBatchManufacturingOrderOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

removeBatchManufacturingOrder : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "removeBatchManufacturingOrder",
    Description: """
        remove all Manufacturing Orders (MOs) associated with a given MO Batch.
    """,
    Response: {Type: removeBatchManufacturingOrderOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "removeBatchManufacturingOrderInput",
                Fields: [
                    {Name: "moBatchId", Type: pipeline.ID, Required: true},
                ],
            },
        },
    ],
    PostScript: """
    {
        "success": true
    }
    """,
    Pipelines: [
        {
            Name:        "fetchManufacturingOrders",
            Description: "Fetches all manufacturing orders associated with the given moBatchId.",
            PreScript: """
            {
                "moBatchId": context.args.input.moBatchId
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                query getManufacturingOrders($moBatchId: ID!) {
                    manufacturingOrders(query: {moBatchId: {eq: $moBatchId}}) {
                        collection {
                            id
                        }
                    }
                }
                """
            },
            PostScript: """
            {
                "manufacturingOrders": args.manufacturingOrders.collection
            }
            """,
            PostValidation: """
                size(args.manufacturingOrders) == 0 ? 'No manufacturing orders found.' : ''
            """,
        },
        {
            Name:        "removeManufacturingOrders",
            Description: "Unplans each manufacturing order.",
            ForEach:     "context.pipeline.fetchManufacturingOrders.manufacturingOrders",
            Test:        "size(context.pipeline.fetchManufacturingOrders.manufacturingOrders) > 0",
            PreScript: """
            {
                "input": {
                    "moId": each.id
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation removeManufacturingOrders($input: removeManufacturingOrderInput!) {
                    removeManufacturingOrder(input: $input) {
                        success
                    }
                }
                """
            }
        },
        {
			Name:        "updateMoBatch"
			Description: "Updates the Manufacturing Order batch status, along with the scheduled date and time"
           PreScript : """
                    {
                        "id": context.args.input.moBatchId,
                        "input": {
                            "status": "Draft",
                            "startDateTime": null,
                            "endDateTime": null,
                            "isDeleted": true
                        }
                    }
                    """
			Operation: pipeline.#GraphqlOperation & {
				Query : """
                    mutation updateMoBatch($input: MOBatchUpdateInput!, $id: ID!) {
                        updateMOBatch(id: $id, input: $input) {
                            id
                            startDateTime
                            endDateTime
                            status
                        }
                    }
                """
			}
		}
    ],
}
