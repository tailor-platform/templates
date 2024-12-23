package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

updateManufacturingOrderBatchStatusOutput : {
    Name: "updateManufacturingOrderBatchStatusOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
    ],
}

updateManufacturingOrderBatchStatus : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "updateManufacturingOrderBatchStatus",
    Description: """
        The pipeline will check if all associated MOs are canceled, then update the MO Batch status to 'Canceled'.
        The pipeline will check if all associated MOs are completed, then update the MO Batch status to 'Completed'.
    """,
    Response: {Type: updateManufacturingOrderBatchStatusOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "updateManufacturingOrderBatchStatusInput",
                Fields: [
                    {Name: "moBatchId", Type: pipeline.ID, Required: true},
                ],
            },
        },
    ],
	PostScript: """
	{
		"success": true,
	}"""
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
                query fetchManufacturingOrders($moBatchId: ID!) {
                    manufacturingOrders(query: {moBatchId: {eq: $moBatchId},isDeleted: {eq: false}}) {
                        collection {
                            id
                            status
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
                size(args.manufacturingOrders) == 0 ? 'No manufacturing order found.' : ''
            """,
        },
        {
			Name:        "updateMoBatch"
			Description: "Updates the Manufacturing Order batch status, along with the scheduled date and time"
			PreHook: common.#Script & {
				Expr: """
                (() => {
                    const manufacturingOrders = context.pipeline.fetchManufacturingOrders.manufacturingOrders;
                    const statuses = manufacturingOrders.map(mo => mo.status);

                    let newStatus = null;

                    if (statuses.includes('In_Progress')) {
                        newStatus = 'In_Progress';
                    } else if (statuses.every(status => status === 'Canceled')) {
                        newStatus = 'Canceled';
                    } else if (statuses.every(status => status === 'Completed')) {
                        newStatus = 'Completed';
                    }

                    if (newStatus === 'Canceled' || newStatus === 'Completed' || newStatus === 'In_Progress') {
                        return {
                            "id": context.args.input.moBatchId,
                            "input": {
                                "status": newStatus,
                            }
                        };
                    } else {
                        return {
                            "id": context.args.input.moBatchId,
                            "input": {}
                        };
                    }
                })()
                """
			}
			Operation: pipeline.#GraphqlOperation & {
				Query : """
                    mutation updateMoBatch($input: MOBatchUpdateInput!, $id: ID!) {
                        updateMOBatch(id: $id, input: $input) {
                            id
                            status
                        }
                    }
                """
			}
			PostScript: """
					{
						"success": true,
					}"""
		}
    ],
}
