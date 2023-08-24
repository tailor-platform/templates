package resolvers

import (
	"tailor.build/scm-adv-cygfedck/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"

)

cancelOrder: pipelinev1.#Resolver & {
	authorization: "true"
	id: "6807640c-7bc4-44c4-b4a7-92e70165ae73"
	name:        "cancelOrder"
	description: "cancel order"
	pipeline: [
		{
			id: "88096519-5c08-4fd7-9650-5c56333a76c3"
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
			id: "e258252c-edc1-44eb-8654-b7fae494b5f6"
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
