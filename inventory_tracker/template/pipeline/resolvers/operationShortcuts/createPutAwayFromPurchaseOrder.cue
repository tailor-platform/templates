package operationShortcuts

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

createPutAwayFromPurchaseOrder: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "createPutAwayFromPurchaseOrder"
	description: """
	The purpose of this Pipeline is to create a single click solution to create a Put Away record from a Purchase Order record.
	This Pipeline follows the following steps:
	1. Get the PurchaseOrder record from ID.
	2. Use the data in the PurchaseOrder as inputs for creating a new PutAway record.
	"""
	inputs: [
		{name: "input"
			required: true
			type: {
				name: "createPutAwayFromPurchaseOrderInput"
				fields: [
					{name: "purchaseOrderID", type: schema.ID, required:  true},
					{name: "putAwayDate", type: schema.Date, required:  false}
				]
			}
		},
	]
	response: {	type: schema.ID	}
	postScript: "context.pipeline.createPutAway.id"
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "purchaseOrder"
			description: "Get the PurchaseOrder record from ID."
			url:         settings.services.gateway
			preScript: "context.args.input"
			graphqlQuery: """
			query purchaseOrder ($purchaseOrderID: ID!) {
			  purchaseOrder (id:$purchaseOrderID) {
				id
				quantity
				}
			}"""
			postScript: "args.purchaseOrder"
		},
				{
			id: {{generateUUID | quote}}
			name:        "createPutAway"
			description: "Use the data in the PurchaseOrder as inputs for creating a new PutAway record."
			url:         settings.services.gateway
			preScript: """
			{
				"purchaseOrderID": context.pipeline.purchaseOrder.id,
				"quantity": context.pipeline.purchaseOrder.quantity,
				"putAwayDate": isNull(context.args.input.putAwayDate) ? date(today()) : context.args.input.putAwayDate
			}
			"""
			graphqlQuery: """
			mutation createPutAway ($purchaseOrderID: ID!, $quantity: Int!, $putAwayDate: Date!) {
			  createPutAway (input: {purchaseOrderID: $purchaseOrderID, quantity: $quantity, putAwayDate: $putAwayDate}) {
				id
				}
			}"""
			postScript: "args.createPutAway"
		},
	]
}
