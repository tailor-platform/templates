package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

cancelManufacturingOrderOutput: {
	Name: "cancelManufacturingOrderOutput"
	Fields: [
		{Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
		{Name: "success", Type: pipeline.Boolean, Required: true},
	]
}

cancelManufacturingOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "cancelManufacturingOrder"
	Description: """
		The purpose of this operation is to cancel a Manufacturing Order (MO) and its associated components. The steps involved are as follows:
		
		1. Fetch all Work Orders and associated MO Line Items for the specified MO, validate their presence, and return detailed information.
		2. Mark Work Orders as deleted by retrieving existing Work Orders, updating their status to deleted, and performing a bulk update to apply the changes.
		3. Mark MO Line Items as deleted by retrieving existing MO Line Items, flagging them as deleted, and performing a bulk update to apply the changes.
		4. Mark the specified MO as deleted by setting the `isDeleted` flag to true and confirming the successful cancellation.
	"""
	Response: {Type: cancelManufacturingOrderOutput}
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "cancelManufacturingOrderInput"
				Fields: [
					{Name: "moId", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "fetchWorkOrders"
			Description: "Fetches all Work Orders and associated Manufacturing Order Line Items for a given Manufacturing Order (MO). Validates the presence of Work Orders and returns detailed information on both Work Orders and MO Line Items."
			PreScript: """
					{
						'moId': context.args.input.moId
					}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
						query fetchWorkOrders($moId: ID!) {

							manufacturingOrder(id: $moId) {
								id
								isDeleted
								name
							}

							workOrders(query: { moId: {eq: $moId}}) {
								collection {
									id
									expectedDuration
									endDate
									moId
									operationId
									realDuration
									startDate
									status
								}
							}

							mOLineItems(query: {moId: {eq: $moId}}) {
								collection {
									id
									moId
									bomLineItemId
									itemMoId
									totalCost
									requiredQuantity
								}
							}
							workOrderLineItems(query: {moId: {eq: $moId}}) {
								collection {
									moId
									moLineItemId
									quantity
									scrapAction
									returnAsNewSkuItemId
									workOrderId
									id
								}
							}				
						}"""
			}
			PostScript: """
					{
						"manufacturingOrder": args.manufacturingOrder,
						"workOrders": args.workOrders,
						"mOLineItems": args.mOLineItems,
						"workOrderLineItems": args.workOrderLineItems,
					}"""
			PostValidation: """
				isNull(context.pipeline.fetchWorkOrders.manufacturingOrder) ?
				['No manufacturing order found for the given ID: ', context.args.input.moId].join('') :
				''
				"""
		},
		{
			Name:        "cancelWorkOrders",
			Description: "Cancels each work order by calling the cancelWorkOrder mutation.",
			ForEach:     "context.pipeline.fetchWorkOrders.workOrders.collection",
			Test:        "size(context.pipeline.fetchWorkOrders.workOrders.collection) > 0",
			PreScript: """
			{
				"input": {
					"workOrderId": each.id
				}
			}
			""",
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation cancelWorkOrder($input: cancelWorkOrderInput!) {
						cancelWorkOrder(input: $input) {
							success
						}
					}
				"""
			},
			PostValidation: """
				!args.cancelWorkOrder.success ?
				'Failed to cancel work order: ' + each.id :
				''
			"""
		},
		{
			Name:        "markMoCanceled"
			Description: "mark mo as canceled"
			PreScript: """
			{
					'id': context.args.input.moId,
					'input': {
						'status':'Canceled',
						'isPlanCreated':false,
						'startDateTime':null,
						'endDateTime':null,
					}
				}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation markMoCanceled (
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
						"manufacturingOrderId": context.args.input.moId,
						"success": true,
					}"""
		},
	]
}
