package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"

)

changeToINTRANSIT: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "changeToINTRANSIT"
	description: "update delivery state to INTRANSIT"
	pipeline: [
		{
			id: {{generateUUID | quote}}
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
			id: {{generateUUID | quote}}
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
