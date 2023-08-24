package resolvers

import (
	"tailor.build/scm-adv-cygfedck/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"

)

editOrder: pipelinev1.#Resolver & {
	authorization: "true"
	id: "4445bb8e-5b57-4fc6-8ed9-0e519150dbb8"
	name:        "editOrder"
	description: "edit order"
	pipeline: [
		{
			id: "5739303b-e41b-45d0-9c9f-718c8d3f056d"
			name:        "getRecords"
			description: "update SALES order record"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
				               query getDeliveries($orderID: ID!) {
				                 deliveries:deliveries(query: {orderID: {eq: $orderID}}) {
				                   collection {
				                     id
				                   }
				                 }
				                inventoryEvents:inventoryEvents(query: {orderID: {eq: $orderID}}) {
				                   collection {
				                     id
				                   }
				                 }
				               }"""
			postScript: "args"
		},
		{
			id: "d92e7587-c745-4c94-b605-c3851b1b2662"
			name:        "updateOrder"
			description: "update order records"
			url:         settings.services.gateway
			preScript: """
				             {
				               "deliveryID": args.deliveries.collection[0].id,
				               "orderID": context.args.input.orderID,
				               "productID": context.args.input.productID,
				               "locationID": context.args.input.locationID,
				               "qty": context.args.input.quantity,
				               "negativeQty": -context.args.input.quantity,
				               "inventoryEventID": args.inventoryEvents.collection[0].id
				             }"""
			graphqlQuery: """
				               mutation editOrder(
				                 $deliveryID: ID!
				                 $orderID: ID!
				                 $productID: ID!
				                 $locationID: ID
				                 $qty: Int!
				                 $negativeQty: Int!
				                 $inventoryEventID: ID!
				               ) {
				                 updateOrder: updateOrder(id: $orderID, input: { quantity: $qty, productID: $productID }) {
				                   id
				                 }

				                 updateDelivery: updateDelivery(
				                   id: $deliveryID
				                   input: { quantity: $qty, productID: $productID, locationID: $locationID }
				                 ) {
				                   id
				                 }
				                 updateInventoryEvent: updateInventoryEvent(
				                   id: $inventoryEventID
				                   input: {
				                     quantity: $negativeQty
				                     productID: $productID
				                     locationID: $locationID
				                   }
				                 ) {
				                   id
				                 }
				               }"""
			postScript: """
				             {
				               "orderID": args.updateOrder.id,
				               "deliveryID": args.updateDelivery.id,
				               "inventoryEventID": args.updateInventoryEvent.id
				             }"""
		},
	]
}
