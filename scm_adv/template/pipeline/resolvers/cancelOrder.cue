package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

cancelOrderInput: {
	name: "cancelOrderInput"
	fields: [
		{ name: "orderID",      type: schema.ID, required: true},
	]
}

cancelOrder: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "cancelOrder"
	description: "cancel order"
	inputs: [
		{ name: "input", type: cancelOrderInput },
	]
	response: { type: schema.Boolean }
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "getRecords"
			description: "get records of cancel order"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
				               query getRecords($orderID: ID) {
				                 deliveries: deliveries(query: { orderID: { eq: $orderID } }) {
				                   collection {
				                     id
				                   }
				                 }
				                 inventoryEvents: inventoryEvents(query: { orderID: { eq: $orderID } }) {
				                   collection {
				                     id
				                   }
				                 }
				               }"""
			postScript: "args"
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteRecords"
			description: "delete records of cancel order"
			url:         settings.services.gateway
			preScript: """
				             {
				               "orderID": context.args.input.orderID,
				               "deliveryID": args.deliveries.collection[0].id,
				               "inventoryEventID": args.inventoryEvents.collection[0].id
				             }"""
			graphqlQuery: """
				               mutation deleteRecords(
				                 $deliveryID: ID!
				                 $inventoryEventID: ID!
				                 $orderID: ID!
				               ) {
				                 deleteDelivery: deleteDelivery(id: $deliveryID)
				                 deleteInventoryEvent: deleteInventoryEvent(id: $inventoryEventID)
				                 deleteOrder: deleteOrder(id: $orderID)
				               }"""
			postScript: "args"
		},
	]
}
