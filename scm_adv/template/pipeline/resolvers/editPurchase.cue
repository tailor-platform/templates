package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

editPurchaseInput: {
	name: "editOrderInput"
	fields: [
		{ name: "orderID",     type: schema.ID, required: true },
		{ name: "quantity",    type: schema.Int, required: true },
		{ name: "productID",   type: schema.ID, required: true },
		{ name: "locationID",  type: schema.ID, required: true },
	]
}

editPurchaseResult: {
	name: "editOrderResult"
	fields: [
		{ name: "orderID",          type: schema.ID },
		{ name: "deliveryID",       type: schema.ID },
		{ name: "inventoryEventID", type: schema.ID },
	]
}

editPurchase: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "editPurchase"
	description: "edit Purchase order"
	inputs: [
		{ name: "input", type:editPurchaseInput },
	]
	response: { type: editPurchaseResult }
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "getRecords"
			description: "get order records"
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
			id: {{generateUUID | quote}}
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
				               "inventoryEventID": args.inventoryEvents.collection[0].id
				             }"""
			graphqlQuery: """
				               mutation editOrder(
				                 $deliveryID: ID!
				                 $orderID: ID!
				                 $productID: ID!
				                 $locationID: ID
				                 $qty: Int!
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
				                     quantity: $qty
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
