package resolvers

import (
	"tailor.build/scm-adv-cygfedck/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"

)

changeToDELIVERED: pipelinev1.#Resolver & {
	authorization: "true"
	id: "52035041-1f42-4c3a-a015-00d80449659d"
	name:        "changeToDELIVERED"
	description: "update delivery state to DELIVERED"
	pipeline: [
		{
			id: "abe7b8de-1526-40db-8da9-ca8f7698bdcf"
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
			id: "3b0b694f-78d9-40e9-b283-c352071c54ea"
			name:        "updateInventoryEvent"
			description: "update inventoryEvent record"
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
				                   input: { deliveryState: DELIVERED }
				                 ) {
				                   id
				                 }
				                 revertInvEvents: createInventoryEvent(
				                   input: {
				                     quantity: $negativeQty
				                     deliveryState: INTRANSIT
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
				                     deliveryState: DELIVERED
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
