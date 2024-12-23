package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

planBatchManufacturingOrderOutput : {
    Name: "planBatchManufacturingOrderOutput",
    Fields: [
        {Name: "success", Type: pipeline.Boolean, Required: true},
        {Name: "startDateTime", Type: pipeline.DateTime},
		{Name: "endDateTime", Type: pipeline.DateTime},
    ],
}

planBatchManufacturingOrder : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "planBatchManufacturingOrder",
    Description: """
        Plans all Manufacturing Orders (MOs) associated with a given MO Batch.
    """,
    Response: {Type: planBatchManufacturingOrderOutput},
    Inputs: [
        {
            Name:     "input",
            Required: true,
            Type: {
                Name: "planBatchManufacturingOrderInput",
                Fields: [
                    {Name: "moBatchId", Type: pipeline.ID, Required: true},
                    {Name: "scheduleDateTime", Type: pipeline.String, Required: true},
                ],
            },
        },
    ],
	PostScript: """
	{
		"success": true,
        "startDateTime": context.pipeline.updateMoBatch.startDateTime,
		"endDateTime": context.pipeline.updateMoBatch.endDateTime,
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
                size(args.manufacturingOrders) == 0 ? 'No manufacturing order found.' : ''
            """,
        },
        {
			Name:        "manufacturingOrderStartAndEndDateTimeVariable"
 			Description: "Sets the start and end dates for each Work Order based on the provided schedule and expected duration.",
			PostHook: common.#Script & {
				Expr: """
					(() => {
						return {
							"manufacturingOrderStartAndEndDateTime": [],
						}
					})()
				"""
			}
			
		},
        {
            Name:        "planManufacturingOrders",
            Description: "Plans each manufacturing order.",
            ForEach:     "context.pipeline.fetchManufacturingOrders.manufacturingOrders",
            Test:        "size(context.pipeline.fetchManufacturingOrders.manufacturingOrders) > 0",
            PreScript: """
            {
                "input": {
                    "manufacturingOrderId": each.id,
                    "scheduleDateTime": context.args.input.scheduleDateTime
                }
            }
            """,
            Operation: pipeline.#GraphqlOperation & {
                Query: """
                mutation planManufacturingOrder($input: PlanManufacturingOrderInput!) {
                    planManufacturingOrder(input: $input) {
                        success
                        startDateTime
                        endDateTime
                    }
                } 
                """
            },
            PostHook: common.#Script & {
				Expr: """
					(() => {

						const originalValue = context.pipeline.manufacturingOrderStartAndEndDateTimeVariable.manufacturingOrderStartAndEndDateTime;

						const response = {
							"manufacturingOrderId": each.id,
							"startDateTime": args.planManufacturingOrder.startDateTime,
							"endDateTime": args.planManufacturingOrder.endDateTime,
						}

						originalValue.push(response)
						context.pipeline.manufacturingOrderStartAndEndDateTimeVariable.manufacturingOrderStartAndEndDateTime = originalValue
						return response
					})()
				"""
			},
        },
        {
			Name:        "updateMoBatch"
			Description: "Updates the Manufacturing Order batch status, along with the scheduled date and time"
			PreHook: common.#Script & {
				Expr: """
				(() => {
					const data = context.pipeline.planManufacturingOrders;

					// Convert strings to Date objects
					const dateTimes = data.map(e => ({
						startDateTime: new Date(e.startDateTime),
						endDateTime: new Date(e.endDateTime)
					}));

					// Calculate min and max dateTimes
					const minDateTime = new Date(Math.min(...dateTimes.map(e => e.startDateTime)));
					const maxDateTime = new Date(Math.max(...dateTimes.map(e => e.endDateTime)));

					return {
						'id': context.args.input.moBatchId,
						'input': {
							'status':'Planned',
							'startDateTime':minDateTime.toISOString(),
							'endDateTime':maxDateTime.toISOString()
						}
					};
				})()
				"""
			}
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
			PostScript: """
					{
						"startDateTime": args.updateMOBatch.startDateTime,
						"endDateTime": args.updateMOBatch.endDateTime,
						"success": true,
					}"""
		}
    ],
}
