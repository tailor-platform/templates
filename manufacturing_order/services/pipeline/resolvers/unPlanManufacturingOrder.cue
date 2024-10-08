package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

unPlanManufacturingOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "unPlanManufacturingOrder"
    Description: """
		The purpose of this operation is to unplan a Manufacturing Order (MO) and its associated Work Orders. The steps involved are as follows:
		
		1. Fetch the details of the Manufacturing Order (MO) including associated Work Orders.
		2. Set or update the details of the Work Orders.
		3. Update the manufacturing order plan flag to reflect the unplanning of the MO.
	"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "UnPlanManufacturingOrderInput"
				Fields: [
					{Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {
		Type: {
			Name: "UnPlanManufacturingOrderOutput"
			Fields: [
				{Name: "success", Type: pipeline.Boolean},
			]
		}
	}
	PostScript: """
	{
		"success": true,
	}"""
	Pipelines: [
		{
			Name:        "getAllWorkOrdersOfMO"
			Description: "Fetches the Manufacturing Order (MO) details including associated Work Orders.",
			PreScript: """
				{
					'manufacturingOrderId': context.args.input.manufacturingOrderId,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query getAllWorkOrdersOfMO($manufacturingOrderId: ID!) {
						manufacturingOrder(id: $manufacturingOrderId) {
							quantity
							id
						}
						
						workOrders(query: {moId: {eq: $manufacturingOrderId}, isDeleted: {eq: false}}) {
							collection {
								id
								expectedDuration
								endDate
								moId
								operationId
								realDuration
								startDate
								status
								isDeleted
							}
						}
					}"""
			}
			PostScript: """
				{
					"workOrders": args.workOrders,
					"manufacturingOrder": args.manufacturingOrder,
				}"""
			PostValidation: """
					isNull(context.pipeline.getAllWorkOrdersOfMO.manufacturingOrder) ?
					['No manufacturing order found for the given ID: ', context.args.input.manufacturingOrderId].join('') :
					size(context.pipeline.getAllWorkOrdersOfMO.workOrders) == 0 ?
					['No work orders found for given ID: ', context.args.input.manufacturingOrderId].join('') :
					''
				"""
		},
		{
			Name:        "workOrder"
			Description: "Sets or updates work order details."
			Test: 		 "size(context.pipeline.getAllWorkOrdersOfMO.workOrders.collection) > 0"
			PreScript:   """
				{
					"input": size(context.pipeline.getAllWorkOrdersOfMO.workOrders.collection)== 0 ? [] : context.pipeline.getAllWorkOrdersOfMO.workOrders.collection.map(e, {
							'id': e.id,
							'isDeleted':e.isDeleted,
							'expectedDuration': e.expectedDuration,
							'endDate': null,
							'moId': e.moId,
							'operationId': e.operationId,
							'realDuration': e.realDuration,
							'startDate': null,
							'status': e.status,
					}),
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation markWorkOrderDeleted (
						$input: [WorkOrderCreateInput]
					) {
						bulkUpsertWorkOrders(input: $input)
					}
				"""
			}
		},
		{
			Name:        "updateMOPlanFlag"
			Description: "Updates the manufacturing order plan flag."
			PreScript: """
			{
					'id': context.args.input.manufacturingOrderId,
					'input': {
						'isPlanCreated':false,
						'startDateTime':null,
						'endDateTime':null
					}
				}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation markMODeleted (
						$input: ManufacturingOrderUpdateInput!,
						$id:ID!
					) {
						updateManufacturingOrder(id: $id,input: $input) {
							id
						}
					}
				"""
			}
			PostScript: """
					{
						"manufacturingOrderId": context.args.input.manufacturingOrderId,
						"success": true,
					}"""
		}
	]
}
