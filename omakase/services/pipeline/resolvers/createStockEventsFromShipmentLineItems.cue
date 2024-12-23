package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline:settings"
)

createStockEventsFromShipmentLineItems: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createStockEventsFromShipmentLineItems"
	Description: """
		The purpose of this Pipeline is to create OperationalStockEvent records from the LineItem records of a Shipment.
		Steps:
		1. Get the ShipmentLineItem records
		
		Verify that the creation is allowed. To do this:
		2. Only create stock events for "INVENTORY" products (filter the ReceiptLineItem records by product type)
		3. If the status is "SHIPPED", throw an error. Because the stock event was already created.
		4. Get stock summary records


		If the input action is "HOLD"
		- Check that the receiptLineItem status is "DRAFT". Else, throw an error
		- Check that there is enough "availableQuantity" for the product to create the stock event. Else, throw an error
		- Create the stock event records to hold the product
		- Update the receiptLineItem to "ONHOLD" status

		If the input action is "RELEASE"
		- Check that the receiptLineItem status is "ONHOLD". Else, throw an error
		- Create the stock event records to release the product (and run calculateStockEventAndUpdateStockSummary)
		- Update the receiptLineItem to "DRAFT" status

		If the input action is "SHIP"
		- Check that the receiptLineItem status is "ONHOLD". Else, throw an error
		- Create the stock event records to ship the product (and run calculateStockEventAndUpdateStockSummary)
		- Create the stock event records to release the product (and run calculateStockEventAndUpdateStockSummary)
		- Update the receiptLineItem to "SHIPPED" status 
		"""
	Response: {Type: pipeline.String}
	PostScript: """
			string(size(context.pipeline.createStockEvents)) + " Stock events created successfully"
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createStockEventsFromShipmentLineItemsInput"
				Fields: [
					{
						Name:     "shipmentItemIDs"
						Type:     pipeline.ID
						Required: true
						Array:    true
					},
					{
						Name: "action"
						Type: pipeline.#EnumType & {
							Name: "StockEventAction"
							AllowedValues: [
								{Value: "HOLD"},
								{Value: "RELEASE"},
								{Value: "SHIP"},
							]
						}
						Required: true
					},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "getShipmentAndLineItems"
			Description: "Run calculateStockEventAndUpdateStockSummary pipeline to refresh the StockEvent and StockEventCalc table."
			Invoker:     settings.adminInvoker
			ForEach:     "context.args.input.shipmentItemIDs"
			PreScript: """
							{
								"shipmentID": each
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
									query ($shipmentID: ID!) {
										shipmentLineItem(id: $shipmentID) {
											id
											variantID
											unitCost
											quantity
											shipmentStatus
											variant {
												displayName
												inventoryType
											}
										}
									}"""
			}
			PostScript: "args.shipmentLineItem"
		},
		{
			Name:        "filteredShipmentLineItems"
			Description: "Filter the ShipmentLineItem records and validate based on the status"
			Invoker:     settings.adminInvoker
			PostScript: """
				context.pipeline.getShipmentAndLineItems.filter(i, i.variant.inventoryType == "INVENTORY")
				"""
			PostValidation: """
				size(context.pipeline.filteredShipmentLineItems.filter(sli, sli.shipmentStatus == "SHIPPED")) > 0 ?
				"LineItem for " + context.pipeline.filteredShipmentLineItems.filter(sli, sli.shipmentStatus == "SHIPPED")[0].variant.displayName + " is already SHIPPED": 
				context.args.input.action == "HOLD" && size(context.pipeline.filteredShipmentLineItems.filter(sli, sli.shipmentStatus != "DRAFT")) > 0 ?
				"LineItem for " + context.pipeline.filteredShipmentLineItems.filter(sli, sli.shipmentStatus != "DRAFT")[0].variant.displayName + " is not in DRAFT status" :
				(context.args.input.action == "RELEASE" || context.args.input.action == "SHIP")
				&& size(context.pipeline.filteredShipmentLineItems.filter(sli, sli.shipmentStatus != "ONHOLD")) > 0 ?
				"LineItem for " + context.pipeline.filteredShipmentLineItems.filter(sli, sli.shipmentStatus != "ONHOLD")[0].variant.displayName + " is not in ONHOLD status" : ""
				"""
		},
		{
			Name:        "checkEnoughAvailableStock"
			Description: "Get the stock summary records"
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
{
  stockSummaries {
    edges {
      node {
        id
        variantID
        availableQuantity
      }
    }
  }
}"""
			}
			PostScript: """
							{
								"stockSummaries": args.stockSummaries.edges,
								"shipmentLineItemsWithoutEnoughStock": context.pipeline.filteredShipmentLineItems
								.map(sli, {
									"variantID": sli.variantID,
									"displayName": sli.variant.displayName,
									"quantity": sli.quantity,
									"availableQuantity": size(args.stockSummaries.edges.filter(ss, ss.node.variantID == sli.variantID)) > 0 ?
										args.stockSummaries.edges.filter(ss, ss.node.variantID == sli.variantID)[0].node.availableQuantity : 0
								})
								.filter(sli, sli.quantity > sli.availableQuantity)
							}"""
			PostValidation: """
				context.args.input.action == "HOLD" &&
				size(context.pipeline.checkEnoughAvailableStock.shipmentLineItemsWithoutEnoughStock) > 0 ?
				"Not enough available stock to hold the inventory for product " 
				+ context.pipeline.checkEnoughAvailableStock.shipmentLineItemsWithoutEnoughStock[0].displayName : ""
				"""
		},
		{
			Name:        "stockEventInput"
			Description: "Based on the action, create the stock event input"
			Invoker:     settings.adminInvoker
			PostScript: """
				(
					context.args.input.action == "HOLD" ?
					context.pipeline.filteredShipmentLineItems.map(sli, {
						"variantID": sli.variantID,
						"shipmentLineItemID": sli.id,
						"incrementalQuantity": sli.quantity,
						"unitCost": sli.unitCost,
						"isOnHold": true
					}) : 
					[]
				) + 
				(
					context.args.input.action == "RELEASE" ?
					context.pipeline.filteredShipmentLineItems.map(sli, {
						"variantID": sli.variantID,
						"shipmentLineItemID": sli.id,
						"incrementalQuantity": decimal(-1) * decimal(sli.quantity),
						"unitCost": sli.unitCost,
						"isOnHold": true
					}) : 
					[]
				) + 
				(
					context.args.input.action == "SHIP" ?
					context.pipeline.filteredShipmentLineItems.map(sli, {
						"variantID": sli.variantID,
						"shipmentLineItemID": sli.id,
						"incrementalQuantity": decimal(-1) * decimal(sli.quantity),
						"unitCost": sli.unitCost,
						"isOnHold": true
					}) +
					context.pipeline.filteredShipmentLineItems.map(sli, {
						"variantID": sli.variantID,
						"shipmentLineItemID": sli.id,
						"incrementalQuantity": decimal(-1) * decimal(sli.quantity),
						"unitCost": sli.unitCost,
						"isOnHold": false
					}): 
					[]
				)
				"""
		},
		{
			Name:        "createStockEvents"
			Description: "Create the stock event records"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.stockEventInput"
			PreScript: """
							{
								"input": each
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
									mutation ($input: OperationalStockEventCreateInput!) {
										createOperationalStockEvent(input: $input){
											id
										}
									}"""
			}
			PostScript: "args.createOperationalStockEvent.id"
		},
		{
			Name:        "calculateStockEventAndUpdateStockSummary"
			Description: "Run calculateStockEventAndUpdateStockSummary pipeline to refresh the StockEvent and StockEventCalc table."
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.createStockEvents"
			PreScript: """
							{
								"stockEventID": each
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
									mutation ($stockEventID: ID!) {
										calculateStockEventAndUpdateStockSummary(input: {stockEventID: $stockEventID})
									}"""
			}
			PostScript: "args.calculateStockEventAndUpdateStockSummary"
		},
		{
			Name:        "updateShipmentLineItemStatus"
			Description: "Update the ShipmentLineItem status"
			Invoker:     settings.adminInvoker
			ForEach:     "context.args.input.shipmentItemIDs"
			PreScript: """
							{
								"shipmentLineItemID": each,
								"status": context.args.input.action == "SHIP" ? 
									"SHIPPED" :
									context.args.input.action == "HOLD" ? 
									"ONHOLD" : 
									"DRAFT"
							}"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
									mutation ($shipmentLineItemID: ID!, $status: ShipmentLineItemShipmentStatus!) {
										updateShipmentLineItem(id: $shipmentLineItemID, input: {shipmentStatus: $status}) {
											id
										}
									}"""
			}
			PostScript: "args.updateShipmentLineItem.id"
		},
	]
}
