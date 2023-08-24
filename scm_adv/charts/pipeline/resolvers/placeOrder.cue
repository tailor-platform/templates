package resolvers

import (
	"tailor.build/scm-adv-cygfedck/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"

)

placeOrder: pipelinev1.#Resolver & {
	authorization: "true"
	id: "8ead790d-f278-482e-8760-ae12bd495832"
	name:        "placeOrder"
	description: "place order"
	pipeline: [
		{
			id: "89ef7057-4d65-445c-8d75-6e082afef89e"
			name:        "createOrder"
			description: "create order record as SALES"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
				  mutation createOrder($quantity: Int, $placedDate: Date, $productID: ID) {
				    createOrder(
				      input: {
				        quantity: $quantity
				        orderType: SALES
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
			id: "ef8eefc8-eea2-4b7d-9bfc-ade44d97b6ad"
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
				                     deliveryType: OUTGOING
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
			id: "21dbde56-e8ae-4afd-86d7-b15bbeb7c54f"
			name:        "createInventoryEvent"
			description: "create inventoryEvent record"
			url:         settings.services.gateway
			preScript: """
				             {
				               "negativeQty": -context.args.input.quantity,
				               "snapshotDate": context.args.input.placedDate,
				               "productID": context.args.input.productID,
				               "locationID": context.args.input.locationID,
				               "orderID": args.orderID,
				               "deliveryID": args.id
				             }"""
			graphqlQuery: """
				               mutation createInventoryEvent(
				                 $negativeQty: Int!
				                 $snapshotDate: Date!
				                 $productID: ID!
				                 $locationID: ID!
				                 $orderID: ID
				                 $deliveryID:ID
				               ) {
				                 createInventoryEvent(
				                   input: {
				                     orderID: $orderID
				                     quantity: $negativeQty
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
