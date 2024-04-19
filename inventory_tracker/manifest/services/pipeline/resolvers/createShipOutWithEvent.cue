package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

createShipOutWithEvent: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "createShipOutWithEvent"
	Description: """
	This API is an alternative to createShipOut. It creates a ShipOut record and then creates a corresponding StockEvent record. Use this API if you want to create a ShipOut record and a StockEvent record in one API call.
	"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createShipOutWithEventInput"
				Fields: [
					{Name: "quantity", Type: pipeline.Int, Required:  true},
					{Name: "salesOrderID", Type: pipeline.ID, Required:  true},
					{Name: "shipOutDate", Type: pipeline.Date, Required:  true}
				]
			}
		},
	]
	Response: {	Type: pipeline.ID	}
	PostScript: "context.pipeline.createShipOut.id"
	Pipelines: [
		{
			Name:        "createShipOut"
			Description: "Create a new ShipOut record."
			Invoker:     settings.adminInvoker
			PreScript: "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation createShipOut ($salesOrderID: ID!, $quantity: Int!, $shipOutDate: Date!){
					createShipOut (input: {salesOrderID: $salesOrderID, quantity: $quantity, shipOutDate: $shipOutDate}) {
						id
						salesOrder{
							lotID
						}
					}
				}"""
			}
			PostScript: "args.createShipOut"
		},{
			Name:        "createStockEvent"
			Description: "Create a new StockEvent record with the ShipOut id created in the previous step."
			Invoker:     settings.adminInvoker
			PreScript: """
			{
				"lotID": context.pipeline.createShipOut.salesOrder.lotID,
				"incrementalQuantity": -context.args.input.quantity,
				"shipOutDate": context.args.input.shipOutDate
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation createStockEvent ($lotID: ID!, $incrementalQuantity: Int!, $shipOutDate: Date!) {
					createStockEvent (input: {lotID: $lotID, incrementalQuantity: $incrementalQuantity, eventDate: $shipOutDate, reason: "Ship Out"}) {
						id
					}
				}"""
			}
			PostScript: "args.createStockEvent"
		},
	]
}
