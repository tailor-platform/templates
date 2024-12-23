package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline:settings"
)

calculateStockEventAndUpdateStockSummary: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "calculateStockEventAndUpdateStockSummary"
	Description: """
		The purpose of this Pipeline is to calculate the stockEventCalc for a stockEvent
		This Pipeline follows the following steps
		1. Get the stock event
		2. Get StockSummary record for the variantID in the stock event.
		3. Update the stockEvent, calculating transactionTotalCost, totalQuantity, totalCost and averageCost
		4. Delete the StockSummary records obtained in step 3.
		5. Create a new StockSummary record for the variantID in the stock event, using the result of step 3.
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "calculateStockEventAndUpdateStockSummaryInput"
				Fields: [
					{Name: "stockEventID", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {Type: pipeline.String}
	PostScript: """
			(!isNull(context.pipeline.updateStockEvent) && !isNull(context.pipeline.createStockSummary.result))? "1 Record(s) updated" : ""
		"""
	Pipelines: [
		// Get all the ids of products with type INVENTORY
		{
			Name:        "getInventoryProductVariantIDs"
			Invoker:     settings.adminInvoker
			Description: "Get all the products with type INVENTORY"
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
query productVariants {
  productVariants(query: {inventoryType: {eq: INVENTORY}}, first: 1000) {
    edges {
      node {
        id
      }
    }
  }
}"""
			}
			PostScript: "args.productVariants.edges.map(e, e.node.id)"
			PostValidation: """
					size(context.pipeline.getInventoryProductVariantIDs) == 0 ?
					'No inventory products found':
					''
				"""
		},
		// 1. Get the stock event
		{
			Name:        "getStockEvent"
			Description: "Get the stock event product."
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.getInventoryProductVariantIDs) > 0"
			PreScript: """
							{
								"stockEventID": context.args.input.stockEventID,
								"variantIDs": context.pipeline.getInventoryProductVariantIDs
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
query operationalStockEvents($stockEventID: ID!, $variantIDs: [ID]) {
  operationalStockEvents(
    query: {id: {eq: $stockEventID}, variantID: {in: $variantIDs}}
  ) {
    edges {
      node {
        id
        unitCost
        incrementalQuantity
        variantID
        onHoldQuantity
        availableQuantity
        inStockQuantity
        isOnHold
        createdAt
        sequence
      }
    }
  }
}"""
			}
			PostScript: """
							{
								"result": size(args.operationalStockEvents.edges) > 0 ? args.operationalStockEvents.edges[0].node: null,
								"canBeRecalculated": isNull(args.operationalStockEvents.edges[0].node.inStockQuantity)
							}"""
			PostValidation: """
					isNull(context.pipeline.getStockEvent.result) ?
					'Stock event not found' :
					!context.pipeline.getStockEvent.canBeRecalculated ?
					'Stock event already calculated':
					''
				"""
		},
		// If sequence is null, assign it
		{
			Name:        "getStockEventSequence"
			Description: "Get the previous stock event."
			Invoker:     settings.adminInvoker
			Test:        "isNull(context.pipeline.getStockEvent.result.sequence)"
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
query operationalStockEvents {
  operationalStockEvents(
    query: {sequence: {ne: null}}
    order: {field: sequence, direction: Desc}
    first: 1
  ) {
    edges {
      node {
        id
        sequence
      }
    }
  }
}"""
			}
			PostScript: """
							{
								"sequence": size(args.operationalStockEvents.edges) > 0 ?
									decimal(args.operationalStockEvents.edges[0].node.sequence) + decimal(1) :
									1
							}"""
		},
		{
			Name:        "getLastStockEvent"
			Description: "Get the previous stock event."
			Invoker:     settings.adminInvoker
			PreScript: """
							{
								"sequence": isNull(context.pipeline.getStockEvent.result.sequence) ?
									context.pipeline.getStockEventSequence.sequence :
									context.pipeline.getStockEvent.result.sequence,
								"variantID": context.pipeline.getStockEvent.result.variantID
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
query operationalStockEvents($sequence: Int, $variantID: ID!) {
  operationalStockEvents(
    query: {and: {sequence: {lt: $sequence}, variantID: {eq: $variantID}}}
    order: {field: sequence, direction: Desc}
    first: 1
  ) {
    edges {
      node {
        id
        variantID
        onHoldQuantity
        availableQuantity
        inStockQuantity
        totalCost
        averageCost
      }
    }
  }
}"""
			}
			PostScript: """
							size(args.operationalStockEvents.edges) > 0 ?
							args.operationalStockEvents.edges[0].node :
							{
								"onHoldQuantity": decimal(0),
								"availableQuantity": decimal(0),
								"inStockQuantity": decimal(0),
								"totalCost": decimal(0),
								"averageCost": decimal(0)
							}"""
		},
		// 3. Update the stockEvent, calculating transactionTotalCost, totalQuantity, totalCost and averageCost
		{
			Name:        "updateStockEvent"
			Description: "Create a stock event calc."
			Invoker:     settings.adminInvoker
			PreScript: """
							{
								"id": context.pipeline.getStockEvent.result.id,
								"input": context.pipeline.getStockEvent.result.isOnHold ?
									compact({
										"availableQuantity": decimal(context.pipeline.getLastStockEvent.availableQuantity) - decimal(context.pipeline.getStockEvent.result.incrementalQuantity),
										"onHoldQuantity": decimal(context.pipeline.getLastStockEvent.onHoldQuantity) + decimal(context.pipeline.getStockEvent.result.incrementalQuantity),
										"totalCost": decimal(context.pipeline.getLastStockEvent.totalCost) +
										(decimal(context.pipeline.getStockEvent.result.unitCost) * decimal(context.pipeline.getStockEvent.result.incrementalQuantity)),
										"sequence": isNull(context.pipeline.getStockEvent.result.sequence) ?
											context.pipeline.getStockEventSequence.sequence :
											context.pipeline.getStockEvent.result.sequence
									}) :
									compact({
										"availableQuantity": decimal(context.pipeline.getLastStockEvent.availableQuantity) + decimal(context.pipeline.getStockEvent.result.incrementalQuantity),
										"onHoldQuantity": decimal(context.pipeline.getLastStockEvent.onHoldQuantity),
										"totalCost": decimal(context.pipeline.getLastStockEvent.totalCost) +
										(decimal(context.pipeline.getStockEvent.result.unitCost) * decimal(context.pipeline.getStockEvent.result.incrementalQuantity)),
										"sequence": isNull(context.pipeline.getStockEvent.result.sequence) ?
											context.pipeline.getStockEventSequence.sequence :
											context.pipeline.getStockEvent.result.sequence
									})
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
									mutation updateOperationalStockEvent($id: ID!, $input: OperationalStockEventUpdateInput!) {
										updateOperationalStockEvent(id: $id, input: $input) {
											id
											variantID
											onHoldQuantity
											availableQuantity
											incrementalQuantity
											totalCost
											averageCost
											isOnHold
										}
									}"""
			}
			PostScript: "args.updateOperationalStockEvent"
		},
		// 4. Delete the StockSummary records
		{
			Name:        "getStockSummary"
			Description: "Get the most recent stock data."
			Invoker:     settings.adminInvoker
			PreScript: """
							{
								"stockEventVariantID": context.pipeline.getStockEvent.result.variantID
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
query stockSummaries($stockEventVariantID: ID!) {
  stockSummaries(query: {variantID: {eq: $stockEventVariantID}}) {
    edges {
      node {
        id
        variantID
        onHoldQuantity
        availableQuantity
        inStockQuantity
        totalCost
        averageCost
      }
    }
  }
}"""
			}
			PostScript: "args.stockSummaries.edges"
		},
		{
			Name:        "deleteStockSummary"
			Description: "Delete the stock summary."
			Invoker:     settings.adminInvoker
			ForEach:     "isNull(context.pipeline.getStockSummary) ? [] : context.pipeline.getStockSummary"
			PreScript: """
							{
								"id": each.node.id
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
									mutation deleteStockSummary($id: ID!) {
										deleteStockSummary(id: $id)
									}"""
			}
			PostScript: """
							{
								"result": args.deleteStockSummary
							}"""
		},
		// 5. Create a new StockSummary record for the variantID in the stock event, using the result of step 3.
		{
			Name:        "createStockSummary"
			Description: "Create a stock summary."
			Invoker:     settings.adminInvoker
			PreScript: """
							{
								"input": compact({
									"variantID": context.pipeline.updateStockEvent.variantID,
									"availableQuantity": context.pipeline.updateStockEvent.availableQuantity,
									"onHoldQuantity": context.pipeline.updateStockEvent.onHoldQuantity,
									"totalCost": context.pipeline.updateStockEvent.totalCost,
								})
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
									mutation createStockSummary($input: StockSummaryCreateInput!) {
										createStockSummary(input: $input) {
											id
										}
									}"""
			}
			PostScript: """
							{
								"result": args.createStockSummary.id
							}"""
		}
	]
}
