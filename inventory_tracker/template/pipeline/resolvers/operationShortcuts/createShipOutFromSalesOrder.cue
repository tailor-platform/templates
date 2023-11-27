package operationShortcuts

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

createShipOutFromSalesOrder: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "createShipOutFromSalesOrder"
	description: """
	The purpose of this Pipeline is to create a single click solution to create a Ship Our record from a Sales Order record.
	This Pipeline follows the following steps:
	1. Get the SalesOrder record from ID.
	2. Use the data in the SalesOrder as inputs for creating a new ShipOut record.
	"""
	inputs: [
		{name: "input"
			required: true
			type: {
				name: "createShipOutFromSalesOrderInput"
				fields: [
					{name: "salesOrderID", type: schema.ID, required:  true},
					{name: "shipOutDate", type: schema.Date, required:  false}
				]
			}
		},
	]
	response: {	type: schema.ID	}
	postScript: "context.pipeline.createShipOut.id"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "salesOrder"
			description: "Get the salesOrder record from ID."
			url:         settings.services.gateway
			preScript: "context.args.input"
			graphqlQuery: """
			query salesOrder ($salesOrderID: ID!) {
			  salesOrder (id:$salesOrderID) {
				id
				quantity
				}
			}"""
			postScript: "args.salesOrder"
		},
				{
			id: {{generateUUID | quote}}
			name:        "createShipOut"
			description: "Use the data in the SalesOrder as inputs for creating a new ShipOut record."
			url:         settings.services.gateway
			preScript: """
			{
				"salesOrderID": context.pipeline.salesOrder.id,
				"quantity": context.pipeline.salesOrder.quantity,
				"shipOutDate": isNull(context.args.input.shipOutDate) ? date(today()) : context.args.input.shipOutDate
			}
			"""
			graphqlQuery: """
			mutation createShipOut ($salesOrderID: ID!, $quantity: Int!, $shipOutDate: Date!) {
			  createShipOut (input: {salesOrderID: $salesOrderID, quantity: $quantity, shipOutDate: $shipOutDate}) {
				id
				}
			}"""
			postScript: "args.createShipOut"
		},
	]
}
