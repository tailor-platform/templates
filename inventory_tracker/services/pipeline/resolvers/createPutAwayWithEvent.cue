package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

createPutAwayWithEvent: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createPutAwayWithEvent"
	Description: """
		This API is an alternative to createPutAway. It creates a PutAway record and then creates a corresponding StockEvent record. Use this API if you want to create a PutAway record and a StockEvent record in one API call.
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createPutAwayWithEventInput"
				Fields: [
					{Name: "id", Type: pipeline.ID, Required: false},
					{Name: "quantity", Type: pipeline.Int, Required: true},
					{Name: "purchaseOrderID", Type: pipeline.ID, Required: true},
					{Name: "putAwayDate", Type: pipeline.Date, Required: true},
					{Name: "lotID", Type: pipeline.ID, Required: false},
				]
			}
		},
	]
	Response: {Type: pipeline.ID}
	PostScript: "context.pipeline.createPutAway.id"
	Pipelines: [
		{
			Name:        "createPutAway"
			Description: "Create a new PutAway record."
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation createPutAway ($id: ID, $purchaseOrderID: ID!, $quantity: Int!, $putAwayDate: Date!){
										createPutAway (input: {id: $id, purchaseOrderID: $purchaseOrderID, quantity: $quantity, putAwayDate: $putAwayDate}) {
											id
										}
									}"""
			}
			PostScript: "args.createPutAway"
		}, {
			Name:        "createLot"
			Description: "Create a new Lot record with the PutAway id created in the previous step."
			Invoker:     settings.adminInvoker
			PreScript: """
				{
					"putAwayID": context.pipeline.createPutAway.id,
					"id": get(context.args.input.lotID)
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation createLot ($putAwayID: ID!, $id: ID){
										createLot (input: {putAwayID: $putAwayID, id: $id}) {
											id
										}
									}"""
			}
			PostScript: "args.createLot"
		}, {
			Name:        "createStockEvent"
			Description: "Create a new StockEvent record with the Lot id created in the previous step."
			Invoker:     settings.adminInvoker
			PreScript: """
				{
					"lotID": context.pipeline.createLot.id,
					"incrementalQuantity": context.args.input.quantity,
					"putAwayDate": context.args.input.putAwayDate
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
									mutation createStockEvent ($lotID: ID!, $incrementalQuantity: Int!, $putAwayDate: Date!) {
										createStockEvent (input: {lotID: $lotID, incrementalQuantity: $incrementalQuantity, eventDate: $putAwayDate, reason: "Put Away"}) {
											id
										}
									}"""
			}
			PostScript: "args.createStockEvent"
		},
	]
}
