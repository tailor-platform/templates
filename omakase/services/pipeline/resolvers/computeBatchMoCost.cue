package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

computeBatchMoCostOutput : {
	Name: "computeBatchMoCostOutput",
	Fields: [
		{Name: "success", Type: pipeline.Boolean, Required: true},
		{Name: "totalCost", Type: pipeline.Float},
		{Name: "expectedTotalCost", Type: pipeline.Float},
		{Name: "unitCost", Type: pipeline.Float},
		{Name: "expectedUnitCost", Type: pipeline.Float},
	],
}

computeBatchMoCost : pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure,
	Name:          "computeBatchMoCost",
	Description: """
		Computes the total cost for a batch of Manufacturing Orders (MOs) based on their associated Work Orders.
	""",
	Response: {Type: computeBatchMoCostOutput},
	Inputs: [
		{
			Name:     "input",
			Required: true,
			Type: {
				Name: "computeBatchMoCostInput",
				Fields: [
					{Name: "moBatchId", Type: pipeline.ID, Required: true},
				],
			},
		},
	],
	Pipelines: [
		{
			Name:        "fetchManufacturingOrders",
			Description: "Fetches all Manufacturing Orders associated with the given moBatchId.",
			PreScript: """
			{
				"moBatchId": context.args.input.moBatchId
			}
			""",
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query fetchManufacturingOrders($moBatchId: ID!) {
					manufacturingOrders(query: {moBatchId: {eq: $moBatchId}, isDeleted: {eq: false}}) {
						collection {
							id
						}
					}
				}
				"""
			},
			PostHook: common.#Script & {
				Expr: """
				(() => {
					const manufacturingOrders = args.manufacturingOrders.collection;

					if (manufacturingOrders.length === 0) {
						return {
							success: false,
							message: 'No Manufacturing Orders found for the given moBatchId.'
						};
					}

					return {
						success: true,
						manufacturingOrders: manufacturingOrders
					};
				})()
				"""
			},
			PostValidation: """
				!context.pipeline.fetchManufacturingOrders.success ?
				context.pipeline.fetchManufacturingOrders.message :
				''
			"""
		},
		{
			Name:        "computeCostForEachMo",
			Description: "Computes the cost for each Manufacturing Order using a forEach loop.",
			ForEach:     "context.pipeline.fetchManufacturingOrders.manufacturingOrders",
			Test:        "size(context.pipeline.fetchManufacturingOrders.manufacturingOrders) > 0",
			PreScript: """
			{
				"manufacturingOrderId": each.id
			}
			""",
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query computeCostForEachMo($manufacturingOrderId: ID!) {
					computeManufacturingOrderCost(input: {manufacturingOrderId: $manufacturingOrderId}) {
						manufacturingOrderTotalCost
						manufacturingOrderTotalExpectedCost
						manufacturingOrderUnitCost
						manufacturingOrderUnitExpectedCost
					}
				}
				"""
			},
			PostScript: """
			{
				"manufacturingOrderId": each.id,
				"manufacturingOrderTotalCost": args.computeManufacturingOrderCost.manufacturingOrderTotalCost,
				"manufacturingOrderTotalExpectedCost": args.computeManufacturingOrderCost.manufacturingOrderTotalExpectedCost,
				"manufacturingOrderUnitCost": args.computeManufacturingOrderCost.manufacturingOrderUnitCost,
				"manufacturingOrderUnitExpectedCost": args.computeManufacturingOrderCost.manufacturingOrderUnitExpectedCost,
			}
			"""
		},
		{
			Name:        "manipulateAndSumAttributes",
			Description: "Aggregates and sums up the computed costs for all Manufacturing Orders.",
			Test:        "size(context.pipeline.computeCostForEachMo) > 0",
			PostHook: common.#Script & {
				Expr: """
				(() => {
					const computedCosts = context.pipeline.computeCostForEachMo;

					const sumOfTotalCost = computedCosts.reduce((sum, mo) => sum + mo.manufacturingOrderTotalCost, 0);
					const sumOfTotalExpectedCost = computedCosts.reduce((sum, mo) => sum + mo.manufacturingOrderTotalExpectedCost, 0);
					const sumOfUnitCost = computedCosts.reduce((sum, mo) => sum + mo.manufacturingOrderUnitCost, 0);
					const sumOfUnitExpectedCost = computedCosts.reduce((sum, mo) => sum + mo.manufacturingOrderUnitExpectedCost, 0);

					return {
						sumOfTotalCost,
						sumOfTotalExpectedCost,
						sumOfUnitCost,
						sumOfUnitExpectedCost,
					};
				})()
				"""
			},
		},
	],
	PostScript: """
	{
		"success": true,
		"totalCost": context.pipeline.manipulateAndSumAttributes.sumOfTotalCost,
		"expectedTotalCost": context.pipeline.manipulateAndSumAttributes.sumOfTotalExpectedCost,
		"unitCost": context.pipeline.manipulateAndSumAttributes.sumOfUnitCost,
		"expectedUnitCost": context.pipeline.manipulateAndSumAttributes.sumOfUnitExpectedCost
	}
	"""
}
