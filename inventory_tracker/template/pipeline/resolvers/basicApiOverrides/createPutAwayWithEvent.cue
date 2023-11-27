package basicApiOverrides

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

createPutAwayWithEvent: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "createPutAwayWithEvent"
	description: """
	This API is an alternative to createPutAway. It creates a PutAway record and then creates a corresponding StockEvent record. Use this API if you want to create a PutAway record and a StockEvent record in one API call.
	"""
	inputs: [
		{name: "input"
			required: true
			type: {
				name: "createPutAwayWithEventInput"
				fields: [
					{name: "id", type: schema.ID, required:  false},
					{name: "quantity", type: schema.Int, required:  true},
					{name: "purchaseOrderID", type: schema.ID, required:  true},
					{name: "putAwayDate", type: schema.Date, required:  true},
					{name: "lotID", type: schema.ID, required:  false}
				]
			}
		},
	]
	response: {	type: schema.ID	}
	postScript: "context.pipeline.createPutAway.id"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "createPutAway"
			description: "Create a new PutAway record."
			url:         settings.services.gateway
			preScript: "context.args.input"
			graphqlQuery: """
			mutation createPutAway ($id: ID, $purchaseOrderID: ID!, $quantity: Int!, $putAwayDate: Date!){
				createPutAway (input: {id: $id, purchaseOrderID: $purchaseOrderID, quantity: $quantity, putAwayDate: $putAwayDate}) {
					id
				}
			}"""
			postScript: "args.createPutAway"
		},{
			id: {{generateUUID | quote}}
			name:        "createLot"
			description: "Create a new Lot record with the PutAway id created in the previous step."
			url:         settings.services.gateway
			preScript: """
			{
				"putAwayID": context.pipeline.createPutAway.id,
				"id": get(context.args.input.lotID)
			}
			"""
			graphqlQuery: """
			mutation createLot ($putAwayID: ID!, $id: ID){
				createLot (input: {putAwayID: $putAwayID, id: $id}) {
					id
				}
			}"""
			postScript: "args.createLot"
		},{
			id: {{generateUUID | quote}}
			name:        "createStockEvent"
			description: "Create a new StockEvent record with the Lot id created in the previous step."
			url:         settings.services.gateway
			preScript: """
			{
				"lotID": context.pipeline.createLot.id,
				"incrementalQuantity": context.args.input.quantity,
				"putAwayDate": context.args.input.putAwayDate
			}
			"""
			graphqlQuery: """
			mutation createStockEvent ($lotID: ID!, $incrementalQuantity: Int!, $putAwayDate: Date!) {
			  createStockEvent (input: {lotID: $lotID, incrementalQuantity: $incrementalQuantity, eventDate: $putAwayDate, reason: "Put Away"}) {
				id
				}
			}"""
			postScript: "args.createStockEvent"
		},
	]
}
