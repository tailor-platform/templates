package resolvers

import (
	"tailor.build/scm-adv-cygfedck/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

placePurchase: pipelinev1.#Resolver & {
	authorization: "true"
	id: "f79d3e14-2e13-476c-ba75-d932005024f6"
	name:        "placePurchase"
	description: "place purchase"
	pipeline: [
		{
			id: "3a85f400-cc9e-4cc7-9a2f-b54be07e3fc5"
			name:        "createOrder"
			description: "create order record as PURCHASE"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
				  mutation createOrder($quantity: Int, $placedDate: Date, $productID: ID) {
				    createOrder(
				      input: {
				        quantity: $quantity
				        orderType: PURCHASE
				        placedDate: $placedDate
				        productID: $productID
				      }
				    ) {
				      id
				    }
				  }
				"""
			postScript: "args.createOrder"
		},
		{
			id: "dea13e26-4c60-4a3e-bb8e-eca6c8b74a73"
			name:        "createDelivery"
			description: "create delivery record"
			url:         settings.services.gateway
			preScript: """
				             {
				               "quantity": context.args.input.quantity,
				               "deliveryDate": context.args.input.placedDate,
				               "productID": context.args.input.productID,
				               "locationID": context.args.input.locationID,
				               "orderID": args.id
				             }"""
			graphqlQuery: """
				               mutation createDelivery(
				                 $quantity: Int!
				                 $deliveryDate: Date
				                 $productID: ID!
				                 $locationID: ID!
				                 $orderID: ID
				               ) {
				                 createDelivery(
				                   input: {
				                     orderID: $orderID
				                     quantity: $quantity
				                     deliveryType: INCOMING
				                     deliveryDate: $deliveryDate
				                     productID: $productID
				                     locationID: $locationID
				                     deliveryState: UNDISPATCHED
				                   }
				                 ) {
				                   id
				                   orderID
				                 }
				               }"""
			postScript: "args.createDelivery"
		},
		{
			id: "95fbe780-dd5e-471f-bfdc-620fe2fb296a"
			name:        "createInventoryEvent"
			description: "create inventoryEvent record"
			url:         settings.services.gateway
			preScript: """
				             {
				               "quantity": context.args.input.quantity,
				               "snapshotDate": context.args.input.placedDate,
				               "productID": context.args.input.productID,
				               "locationID": context.args.input.locationID,
				               "orderID": args.orderID,
				               "deliveryID": args.id
				             }"""
			graphqlQuery: """
				               mutation createInventoryEvent(
				                 $quantity: Int!
				                 $snapshotDate: Date!
				                 $productID: ID!
				                 $locationID: ID!
				                 $orderID: ID
				                 $deliveryID:ID
				               ) {
				                 createInventoryEvent(
				                   input: {
				                     orderID: $orderID
				                     quantity: $quantity
				                     productID: $productID
				                     locationID: $locationID
				                     snapshotDate:$snapshotDate
				                     deliveryID:$deliveryID
				                     deliveryState: UNDISPATCHED
				                   }
				                 ) {
				                   id
				                 }
				               }"""
			postScript: "context.pipeline.createOrder"
		},
	]
}
