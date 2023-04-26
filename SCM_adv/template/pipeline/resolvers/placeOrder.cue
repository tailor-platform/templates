package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"

)

placeOrder: pipelinev1.#Resolver & {
        id:          {{ generateUUID | quote }}
        name:        "placeOrder"
        description: "place order"
        pipeline: [
          {
              id: {{ generateUUID | quote }}
              name: "createOrder"
              description: "create order record as SALES"
              url: settings.services.gateway
              preScript: "context.args.input"
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
              id: {{ generateUUID | quote }}
              name: "createDelivery"
              description: "create delivery record"
              url: settings.services.gateway
              preScript: """
              {
                "quantity": context.args.input.quantity,
                "deliveryDate": context.args.input.placedDate,
                "productID": context.args.input.productID,
                "locationID": context.args.input.locationID,
                "orderID": args.id
              } """
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
                } """
              postScript: "args.createDelivery"
          },
          {
              id: {{ generateUUID | quote }}
              name: "createInventoryEvent"
              description: "create inventoryEvent record"
              url: settings.services.gateway
              preScript: """
              {
                "negativeQty": -context.args.input.quantity,
                "snapshotDate": context.args.input.placedDate,
                "productID": context.args.input.productID,
                "locationID": context.args.input.locationID,
                "orderID": args.orderID,
                "deliveryID": args.id
              } """
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
                } """
              postScript: "args.createInventoryEvent"
          }
        ]
      }
