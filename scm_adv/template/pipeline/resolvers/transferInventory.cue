package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

transferInventoryInput: {
	name: "transferInventoryInput"
	fields: [
		{ name: "quantity",                 type: schema.Int, required: true },
		{ name: "deliveryDate",             type: schema.Date, required: true },
		{ name: "productID",                type: schema.ID, required: true },
		{ name: "transferOutID",            type: schema.ID, required: true },
		{ name: "transferInID",             type: schema.ID, required: true},
	]
}

transferInventoryResult: {
	name: "transferInventoryResult"
	fields: [
		{ name: "transferInID",             type: schema.ID },
		{ name: "transferOutID",            type: schema.ID },
	]
}

transferInventory: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "transferInventory"
	description: "transfer inventory between locations"
	inputs: [
		{ name: "input", type:transferInventoryInput },
	]
	response: { type: transferInventoryResult }
	pipeline: [
		{
			id: {{generateUUID | quote}}
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
			id: {{generateUUID | quote}}
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
