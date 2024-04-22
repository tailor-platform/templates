package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

createPutAwayFromPurchaseOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "createPutAwayFromPurchaseOrder"
	Description: """
	The purpose of this Pipeline is to create a single click solution to create a Put Away record from a Purchase Order record.
	This Pipeline follows the following steps:
	1. Get the PurchaseOrder record from ID.
	2. Use the data in the PurchaseOrder as inputs for creating a new PutAway record.
	"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createPutAwayFromPurchaseOrderInput"
				Fields: [
					{Name: "purchaseOrderID", Type: pipeline.ID, Required:  true},
					{Name: "putAwayDate", Type: pipeline.Date, Required:  false}
				]
			}
		},
	]
	Response: {	Type: pipeline.ID	}
	PostScript: "context.pipeline.createPutAway.id"
	Pipelines: [
		{
	
			Name:        "purchaseOrder"
			Description: "Get the PurchaseOrder record from ID."
			Invoker:     settings.adminInvoker
			PreScript: "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query purchaseOrder ($purchaseOrderID: ID!) {
					purchaseOrder (id:$purchaseOrderID) {
						id
						quantity
					}
				}"""
			}
			PostScript: "args.purchaseOrder"
		},
				{
	
			Name:        "createPutAway"
			Description: "Use the data in the PurchaseOrder as inputs for creating a new PutAway record."
			Invoker:     settings.adminInvoker
			PreScript: """
			{
				"purchaseOrderID": context.pipeline.purchaseOrder.id,
				"quantity": context.pipeline.purchaseOrder.quantity,
				"putAwayDate": isNull(context.args.input.putAwayDate) ? date(today()) : context.args.input.putAwayDate
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation createPutAway ($purchaseOrderID: ID!, $quantity: Int!, $putAwayDate: Date!) {
					createPutAway (input: {purchaseOrderID: $purchaseOrderID, quantity: $quantity, putAwayDate: $putAwayDate}) {
						id
					}
				}"""
			}
			PostScript: "args.createPutAway"
		},
	]
}
