package resolvers

import (
	"tailor.build/scm-adv-cygfedck/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"

)

changeToINTRANSIT: pipelinev1.#Resolver & {
	authorization: "true"
	id: "9c404b61-e9fe-45b2-9806-16bc3832f44e"
	name:        "changeToINTRANSIT"
	description: "update delivery state to INTRANSIT"
	pipeline: [
		{
			id: "6cd333fc-90b4-4822-adcd-1d404ffc6791"
			name:        "getInventoryEvents"
			description: "update delivery record"
			url:         settings.services.gateway
			preScript:   "context.args.input"
			graphqlQuery: """
				               query getInventoryEvents($deliveryID: ID!) {
				                 inventoryEvents(query: {deliveryID: {eq: $deliveryID}}) {
				                   collection {
				                     id
				                     delivery{
				                       id
				                       productID
				                       deliveryType
				                       locationID
				                       orderID
				                       quantity
				                     }
				                   }
				                 }
				               }"""
			postScript: "args.inventoryEvents"
		},
		{
			id: "6c165ca2-d252-40ce-80bb-76b804325cde"
			name:        "updateRecords"
			description: "update both delivery and inventoryEvent record"
			url:         settings.services.gateway
			preScript: """
				             {
				               "deliveryID": args.collection[0].delivery.id,
				               "orderID": args.collection[0].delivery.orderID,
				               "productID": args.collection[0].delivery.productID,
				               "locationID": args.collection[0].delivery.locationID,
				               "qty": args.collection[0].delivery.quantity,
				               "negativeQty": -args.collection[0].delivery.quantity,
				               "snapshotDate": context.args.input.deliveryDate
				             }"""
			graphqlQuery: """
				               mutation updateRecords(
				                 $deliveryID: ID!
				                 $negativeQty: Int!
				                 $orderID: ID
				                 $locationID: ID!
				                 $productID: ID!
				                 $snapshotDate: Date!
				                 $qty: Int!
				               ) {
				                 updateDelivery: updateDelivery(
				                   id: $deliveryID
				                   input: { deliveryState: INTRANSIT }
				                 ) {
				                   id
				                 }
				                 revertInvEvents: createInventoryEvent(
				                   input: {
				                     quantity: $negativeQty
				                     deliveryState: UNDISPATCHED
				                     locationID: $locationID
				                     productID: $productID
				                     snapshotDate: $snapshotDate
				                     orderID: $orderID
				                   }
				                 ) {
				                   id
				                 }
				                 createInvEvents: createInventoryEvent(
				                   input: {
				                     quantity: $qty
				                     deliveryState: INTRANSIT
				                     locationID: $locationID
				                     productID: $productID
				                     snapshotDate: $snapshotDate
				                     orderID: $orderID
				                   }
				                 ) {
				                   id
				                 }
				               }"""
			postScript: """
				             {
				               "deliveryID": args.updateDelivery.id,
				               "inventoryEventID": args.createInvEvents.id,
				               "revertInventoryEventID": args.revertInvEvents.id
				             }"""
		},
	]
}
