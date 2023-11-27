package basicApiOverrides

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

createShipOutWithEvent: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "createShipOutWithEvent"
	description: """
	This API is an alternative to createShipOut. It creates a ShipOut record and then creates a corresponding StockEvent record. Use this API if you want to create a ShipOut record and a StockEvent record in one API call.
	"""
	inputs: [
		{name: "input"
			required: true
			type: {
				name: "createShipOutWithEventInput"
				fields: [
					{name: "quantity", type: schema.Int, required:  true},
					{name: "salesOrderID", type: schema.ID, required:  true},
					{name: "shipOutDate", type: schema.Date, required:  true}
				]
			}
		},
	]
	response: {	type: schema.ID	}
	postScript: "context.pipeline.createShipOut.id"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "createShipOut"
			description: "Create a new ShipOut record."
			url:         settings.services.gateway
			preScript: "context.args.input"
			graphqlQuery: """
			mutation createShipOut ($salesOrderID: ID!, $quantity: Int!, $shipOutDate: Date!){
				createShipOut (input: {salesOrderID: $salesOrderID, quantity: $quantity, shipOutDate: $shipOutDate}) {
					id
					salesOrder{
						lotID
					}
				}
			}"""
			postScript: "args.createShipOut"
		},{
			id: {{generateUUID | quote}}
			name:        "createStockEvent"
			description: "Create a new StockEvent record with the ShipOut id created in the previous step."
			url:         settings.services.gateway
			preScript: """
			{
				"lotID": context.pipeline.createShipOut.salesOrder.lotID,
				"incrementalQuantity": -context.args.input.quantity,
				"shipOutDate": context.args.input.shipOutDate
			}
			"""
			graphqlQuery: """
			mutation createStockEvent ($lotID: ID!, $incrementalQuantity: Int!, $shipOutDate: Date!) {
			  createStockEvent (input: {lotID: $lotID, incrementalQuantity: $incrementalQuantity, eventDate: $shipOutDate, reason: "Ship Out"}) {
				id
				}
			}"""
			postScript: "args.createStockEvent"
		},
	]
}
