package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

changeToDELIVEREDInput: {
	name: "changeToDELIVEREDInput"
	fields: [
		{ name: "deliveryID",               type: schema.ID, required: true },
		{ name: "deliveryDate",             type: schema.Date, required: true},
	]
}

changeToDELIVEREDResult: {
	name: "changeToDELIVEREDResult"
	fields: [
		{ name: "deliveryID",               type: schema.ID },
		{ name: "inventoryEventID",         type: schema.ID },
		{ name: "revertInventoryEventID",   type: schema.ID },
	]
}

changeToDELIVERED: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "changeToDELIVERED"
	description: "update delivery state to DELIVERED"
	inputs: [
		{ name: "input", type:changeToDELIVEREDInput },
	]
	response: { type: changeToDELIVEREDResult }
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
