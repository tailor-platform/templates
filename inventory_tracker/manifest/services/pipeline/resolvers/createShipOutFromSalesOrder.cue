package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

createShipOutFromSalesOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "createShipOutFromSalesOrder"
	Description: """
	The purpose of this Pipeline is to create a single click solution to create a Ship Our record from a Sales Order record.
	This Pipeline follows the following steps:
	1. Get the SalesOrder record from ID.
	2. Use the data in the SalesOrder as inputs for creating a new ShipOut record.
	"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createShipOutFromSalesOrderInput"
				Fields: [
					{Name: "salesOrderID", Type: pipeline.ID, Required:  true},
					{Name: "shipOutDate", Type: pipeline.Date, Required:  false}
				]
			}
		},
	]
	Response: {	Type: pipeline.ID	}
	PostScript: "context.pipeline.createShipOut.id"
	Pipelines: [
		{
			Name:        "salesOrder"
			Description: "Get the salesOrder record from ID."
			Invoker:     settings.adminInvoker
			PreScript: "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query salesOrder ($salesOrderID: ID!) {
					salesOrder (id:$salesOrderID) {
						id
						quantity
					}
				}"""
			}
			PostScript: "args.salesOrder"
		},
		{
			Name:        "createShipOut"
			Description: "Use the data in the SalesOrder as inputs for creating a new ShipOut record."
			Invoker:     settings.adminInvoker
			PreScript: """
			{
				"salesOrderID": context.pipeline.salesOrder.id,
				"quantity": context.pipeline.salesOrder.quantity,
				"shipOutDate": isNull(context.args.input.shipOutDate) ? date(today()) : context.args.input.shipOutDate
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation createShipOut ($salesOrderID: ID!, $quantity: Int!, $shipOutDate: Date!) {
					createShipOut (input: {salesOrderID: $salesOrderID, quantity: $quantity, shipOutDate: $shipOutDate}) {
						id
					}
				}"""
			}
			PostScript: "args.createShipOut"
		},
	]
}
