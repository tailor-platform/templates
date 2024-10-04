package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

computeManufacturingOrderCost: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "computeManufacturingOrderCost"
	Description: """
		The purpose of this operation is to compute the total cost and duration for a Manufacturing Order (MO) and its associated components. The steps involved are as follows:
		
		1. Fetch the MO details, including associated Line Items and Work Orders, and validate the existence of Work Orders.
		2. Calculate the total cost and duration for each Work Order associated with the MO by iterating through the collection of Work Orders and performing individual cost calculations.
		3. Aggregate the total cost and duration from the calculated costs of each Work Order to produce a summarized response.
	"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "ComputeManufacturingOrderCostInput"
				Fields: [
					{Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {
		Type: {
			Name: "ComputeManufacturingOrderCostOutput"
			Fields: [
				{Name: "moLineItemsTotalCost", Type: pipeline.Float},
				{Name: "workOrderTotalCost", Type: pipeline.Float},
				{Name: "workOrderTotalDuration", Type: pipeline.Float},
				{Name: "workOrderTotalExpectedCost", Type: pipeline.Float},
				{Name: "workOrderTotalExpectedDuration", Type: pipeline.Float},
				{Name: "manufacturingOrderTotalCost", Type: pipeline.Float},
				{Name: "manufacturingOrderTotalExpectedCost", Type: pipeline.Float},
				{Name: "manufacturingOrderUnitCost", Type: pipeline.Float},
				{Name: "manufacturingOrderUnitExpectedCost", Type: pipeline.Float},
				{
						Name:  "calculatedWorkOrders"
						Array: true
						Type: {
							Name: "calculatedWorkOrderListResult"
							Fields: [
								{Name: "workOrderId", Type: pipeline.ID},
								{Name: "totalCost", Type: pipeline.Float},
								{Name: "totalDuration", Type: pipeline.Float},
								{Name: "totalExpectedCost", Type: pipeline.Float},
								{Name: "totalExpectedDuration", Type: pipeline.Float},
							]
						}
					}
			]
		}
	}
	PostScript: """
	{
		"moLineItemsTotalCost": context.pipeline.fetchMOLineItemsAndWorkOrders.moLineItemsTotalCost,
		"workOrderTotalCost": context.pipeline.manipulateResponseArray.sumOfCost,
		"workOrderTotalDuration": context.pipeline.manipulateResponseArray.sumOfDuration,
		"workOrderTotalExpectedCost": context.pipeline.manipulateResponseArray.sumOfExpectedCost,
		"workOrderTotalExpectedDuration": context.pipeline.manipulateResponseArray.sumOfExpectedDuration,
		"calculatedWorkOrders": context.pipeline.manipulateResponseArray.calculatedWorkOrdersList,
		"manufacturingOrderTotalCost": decimal(context.pipeline.fetchMOLineItemsAndWorkOrders.moLineItemsTotalCost) + decimal(context.pipeline.manipulateResponseArray.sumOfCost),
		"manufacturingOrderTotalExpectedCost": decimal(context.pipeline.fetchMOLineItemsAndWorkOrders.moLineItemsTotalCost) + decimal(context.pipeline.manipulateResponseArray.sumOfExpectedCost),
		"manufacturingOrderUnitCost": (decimal(context.pipeline.fetchMOLineItemsAndWorkOrders.moLineItemsTotalCost) + decimal(context.pipeline.manipulateResponseArray.sumOfCost)) / decimal(context.pipeline.fetchMOLineItemsAndWorkOrders.quantity),
		"manufacturingOrderUnitExpectedCost": (decimal(context.pipeline.fetchMOLineItemsAndWorkOrders.moLineItemsTotalCost) + decimal(context.pipeline.manipulateResponseArray.sumOfExpectedCost)) / decimal(context.pipeline.fetchMOLineItemsAndWorkOrders.quantity),
	}"""
	Pipelines: [
		{
			Name:        "fetchMOLineItemsAndWorkOrders"
			Description: "Fetches the Manufacturing Order (MO) details including associated Line Items and Work Orders. Aggregates the total cost of MO Line Items and validates the existence of Work Orders.",
			PreScript: """
				{
					'manufacturingOrderId': context.args.input.manufacturingOrderId,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query fetchMOLineItemsAndWorkOrders($manufacturingOrderId: ID!) {
						manufacturingOrder(id: $manufacturingOrderId) {
							quantity
							id
						}

						workOrders(query: {moId: {eq: $manufacturingOrderId}, isDeleted: {eq: false}}) {
							collection {
								id
							}
						}

						aggregateMOLineItems(query: {moId: {eq: $manufacturingOrderId}, isDeleted: {eq: false}}) {
							sum {
								totalCost
							}
						}
					}"""
			}
			PostScript: """
				{
					"manufacturingOrder": args.manufacturingOrder,
				    "moLineItemsTotalCost": isNull(args.aggregateMOLineItems[0].sum.totalCost) ? 0.0 : decimal(args.aggregateMOLineItems[0].sum.totalCost),
					"workOrders": args.workOrders,
					"quantity": get(args.manufacturingOrder.quantity, 0),
				}"""
			PostValidation: """
				isNull(context.pipeline.fetchMOLineItemsAndWorkOrders.manufacturingOrder) ?
				['No manufacturing order found for the given ID: ', context.args.input.manufacturingOrderId].join('') :
				''
				"""
		},
		{
			Name:        "calculateCostForWorkOrder"
			Description: "Calculates the total cost and duration for each Work Order associated with a Manufacturing Order. Iterates through the collection of Work Orders to perform individual cost calculations.",
			ForEach:	 "context.pipeline.fetchMOLineItemsAndWorkOrders.workOrders.collection"
			Test: 		 "size(context.pipeline.fetchMOLineItemsAndWorkOrders.workOrders.collection) > 0"
			PreScript: """
			{
				"workOrderId": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query calculateCost($workOrderId: ID!) {
					computeWorkOrderCost(
						input: {workOrderId: $workOrderId}
					) {
						totalCost
						totalDuration
						totalExpectedCost
						totalExpectedDuration
					}
				}"""
			}
			PostScript: """
				{
				    "workOrderId": each.id,
					"totalCost": args.computeWorkOrderCost.totalCost,
					"totalDuration": args.computeWorkOrderCost.totalDuration,
					"totalExpectedCost": args.computeWorkOrderCost.totalExpectedCost,
					"totalExpectedDuration": args.computeWorkOrderCost.totalExpectedDuration,
				}"""
		},
		{
			Name:        "manipulateResponseArray"
			Description: "Aggregates the total cost and duration from the calculated costs of each Work Order. Processes the results from the previous step to produce a summarized response.",
			Test: 		 "size(context.pipeline.calculateCostForWorkOrder) > 0"
			PostHook: common.#Script & {
				Expr: """
					(() => {
						const calculatedWorkOrdersList = context.pipeline.calculateCostForWorkOrder;
						const sumOfCost = calculatedWorkOrdersList.reduce((sum, item) => {
							return (sum + item.totalCost)
						}, 0);

						const sumOfDuration = calculatedWorkOrdersList.reduce((sum, item) => {
							return (sum + item.totalDuration)
						}, 0);

						const sumOfExpectedCost = calculatedWorkOrdersList.reduce((sum, item) => {
							return (sum + item.totalExpectedCost)
						}, 0);

						const sumOfExpectedDuration = calculatedWorkOrdersList.reduce((sum, item) => {
							return (sum + item.totalExpectedDuration)
						}, 0);

						return {
							sumOfCost,
							sumOfDuration,
							sumOfExpectedCost,
							sumOfExpectedDuration,
							calculatedWorkOrdersList
						}
					})()
				"""
			}
		},
	]
}
