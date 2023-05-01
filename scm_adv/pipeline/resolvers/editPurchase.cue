package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"

)

editPurchase: pipelinev1.#Resolver & {
        id:          {{ generateUUID | quote }}
        name:        "editPurchase"
        description: "edit Purchase order"
        pipeline: [
          {
              id: {{ generateUUID | quote }}
              name: "getRecords"
              description: "get order records"
              url: settings.services.gateway
              preScript: "context.args.input"
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
                } """
              postScript: "args"
          },
          {
              id: {{ generateUUID | quote }}
              name: "updateOrder"
              description: "update order records"
              url: settings.services.gateway
              preScript: """
              {
                "deliveryID": args.deliveries.collection[0].id,
                "orderID": context.args.input.orderID,
                "productID": context.args.input.productID,
                "locationID": context.args.input.locationID,
                "qty": context.args.input.quantity,
                "inventoryEventID": args.inventoryEvents.collection[0].id
              } """
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
                } """
              postScript: """
              {
                "orderID": args.updateOrder.id,
                "deliveryID": args.updateDelivery.id,
                "inventoryEventID": args.updateInventoryEvent.id
              } """
          },
        ]
      }
