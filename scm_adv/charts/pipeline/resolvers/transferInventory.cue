package resolvers

import (
	"tailor.build/scm-adv-cygfedck/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"

)

transferInventory: pipelinev1.#Resolver & {
	authorization: "true"
	id: "7c63c9d3-99bc-4111-81a3-74319a6a1df0"
	name:        "transferInventory"
	description: "transfer inventory between locations"
	pipeline: [
		{
			id: "474ea560-b4ae-4e67-8384-41b85e7dda30"
			name:        "createDelivery"
			description: "create deliveries for transfer"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
				               mutation createDelivery(
				                 $quantity: Int!
				                 $deliveryDate: Date
				                 $productID: ID!
				                 $transferOutID: ID!
				                 $transferInID: ID!
				               ) {
				                 transferIn:createDelivery(
				                   input: {
				                     quantity: $quantity
				                     deliveryType: TRANSFER
				                     deliveryDate: $deliveryDate
				                     productID: $productID
				                     locationID: $transferInID
				                     deliveryState:INTRANSIT
				                   }
				                 ) {
				                   id
				                 }
				                 transferOut:createDelivery(
				                   input: {
				                     quantity: $quantity
				                     deliveryType: TRANSFER
				                     deliveryDate: $deliveryDate
				                     productID: $productID
				                     locationID: $transferOutID
				                     deliveryState:INTRANSIT
				                   }
				                 ) {
				                   id
				                 }
				               }"""
			postScript: "args"
		},
		{
			id: "16fef5c0-bfc9-42e7-b1e9-e1d5b9d69d15"
			name:        "createInventoryEvents"
			description: "create inventory events for transfer"
			url:         settings.services.gateway
			preScript: """
				             {
				               "qty": context.args.input.quantity,
				               "negativeQty": -context.args.input.quantity,
				               "deliveryDate": context.args.input.deliveryDate,
				               "productID": context.args.input.productID,
				               "transferOutID": context.args.input.transferOutID,
				               "transferInID": context.args.input.transferInID,
				               "transferInDeliveryID": args.transferIn.id,
				               "transferOutDeliveryID": args.transferOut.id
				             }"""
			graphqlQuery: """
				               mutation createInventory(
				                 $qty: Int!
				                 $negativeQty: Int!
				                 $deliveryDate: Date!
				                 $productID: ID!
				                 $transferOutID: ID!
				                 $transferInID: ID!
				                 $transferInDeliveryID:ID
				               	$transferOutDeliveryID:ID
				               ) {
				                 transferIn:createInventoryEvent(
				                   input: {
				                     deliveryID:$transferInDeliveryID
				                     quantity: $qty
				                     snapshotDate: $deliveryDate
				                     productID: $productID
				                     locationID: $transferInID
				                     deliveryState:INTRANSIT
				                   }
				                 ) {
				                   id
				                 }
				                 transferOut:createInventoryEvent(
				                   input: {
				                     deliveryID: $transferOutDeliveryID
				                     quantity: $negativeQty
				                     snapshotDate: $deliveryDate
				                     productID: $productID
				                     locationID: $transferOutID
				                     deliveryState:INTRANSIT
				                   }
				                 ) {
				                   id
				                 }
				               }"""
			postScript: """
				             {
				               "transferInID": args.transferIn.id,
				               "transferOutID": args.transferOut.id
				             }"""
		},
	]
}
