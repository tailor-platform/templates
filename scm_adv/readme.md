# Advanced SCM

## Overview
This SCM application has 5 types:
- Delivery: This type stores delivery data.   A record will be created for each order.
- Product: This type stores product master data.
- Order: This type stores order data.
- Location: This type stores location master data, which explains where to deliver the product.
- InventoryEvent: This type records events that impact inventory status.
A record will be created when an order is placed or delivery status is changed.


In this application, inventory status is managed by InventoryEvent records.
The InventoryEvent are created at the events which change the inventory status.
If you want to summarize the inventory data based on products, delivery status, etc. you can use `aggregateInventoryEvents`
query.

## Delivery Status transition
```mermaid
flowchart LR
    UNDISPATCHED --> INTRANSIT --> DELIVERED
```
When an order is created, its delivery status is set to UNDISPATCHED. When the order is shipped, we can change the status to INTRANSIT using the changeToINTRANSIT mutation.
Similarly, when the order is delivered, we can change the status to DELIVERED using the changeToDELIVERED mutation.
Each of these mutations is defined as a pipeline resolver, which means that multiple mutations are performed to update types based on the business logic.
Therefore, when updating the delivery status, we must call these pipeline mutations instead of using the auto-generated mutations in Tailor DB, such as updateDelivery.


## Usage

To deploy this template, please refer to the instructions [here](https://www.tailor.tech/templates/advancedscm).

To learn more about the files provided in this template, please refer to the [Tailor Platform documentation](https://docs.tailor.tech/).


## Sample mutations

```graphql
mutation changeToINTRANSIT {
  changeToINTRANSIT(
    input: {
      deliveryID: $deliveryID
      deliveryDate: $deliveryDate
    }
  ) {
    deliveryID
    inventoryEventID
    revertInventoryEventID
  }
}
```

```graphql
mutation changeToDELIVERED {
  changeToDELIVERED(
    input: {
      deliveryID: $deliveryID
      deliveryDate: $deliveryDate
    }
  ) {
    deliveryID
    inventoryEventID
    revertInventoryEventID
  }
}
```

#### To see current product quantities per status, location, etc. please use this GQL.
Please update `groupBy` based on your requirement.
```graphql
query aggregateInventoryEvents {
  aggregateInventoryEvents {
    sum {
      quantity
    }
    groupBy {
      deliveryState
      deliveryID
      toDay{
        snapshotDate
      }
    }
  }
}
```

# Index of pipeline mutations
* [cancelOrder](#cancelOrder)
* [changeToDELIVERED](#changeToDELIVERED)
* [changeToINTRANSIT](#changeToINTRANSIT)
* [editOrder](#editOrder)
* [editPurchase](#editPurchase)
* [placeOrder](#placeOrder)
* [placePurchase](#placePurchase)
* [transferInventory](#transferInventory)

# cancelOrder
Cancel order.

## Pipelines
|Name|Description
|----|-----
(1) [getRecords](#1-getRecords)|get records of cancel order
(2) [deleteRecords](#2-deleteRecords)|delete records of cancel order

## Queries
### (1) getRecords
PreScript
```cue
context.args.input
```
Query
```graphql
query getRecords($orderID: ID) {
  deliveries: deliveries(query: { orderID: { eq: $orderID } }) {
    collection {
      id
    }
  }
  inventoryEvents: inventoryEvents(query: { orderID: { eq: $orderID } }) {
    collection {
      id
    }
  }
}
```

### (2) deleteRecords
PreScript
```cue
{
  "orderID": context.args.input.orderID,
  "deliveryID": args.deliveries.collection[0].id,
  "inventoryEventID": args.inventoryEvents.collection[0].id
}
```
Query
```graphql
mutation deleteRecords(
  $deliveryID: ID!
  $inventoryEventID: ID!
  $orderID: ID!
) {
  deleteDelivery: deleteDelivery(id: $deliveryID)
  deleteInventoryEvent: deleteInventoryEvent(id: $inventoryEventID)
  deleteOrder: deleteOrder(id: $orderID)
}
```

# changeToDELIVERED
Update delivery state to DELIVERED.

## Pipelines
|Name|Description
|----|-----
(1) [getInventoryEvents](#1-getInventoryEvents)|update delivery record
(2) [updateInventoryEvent](#2-updateInventoryEvent)|update inventoryEvent record

## Queries
### (1) getInventoryEvents
PreScript
```cue
context.args.input
```
Query
```graphql
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
}
```

### (2) updateInventoryEvent
PreScript
```cue
{
  "deliveryID": args.collection[0].delivery.id,
  "orderID": args.collection[0].delivery.orderID,
  "productID": args.collection[0].delivery.productID,
  "locationID": args.collection[0].delivery.locationID,
  "qty": args.collection[0].delivery.quantity,
  "negativeQty": -args.collection[0].delivery.quantity,
  "snapshotDate": context.args.input.deliveryDate
}
```
Query
```graphql
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
}
```

# changeToINTRANSIT
Update delivery state to INTRANSIT.

## Pipelines
|Name|Description
|----|-----
(1) [getInventoryEvents](#1-getInventoryEvents)|update delivery record
(2) [updateRecords](#2-updateRecords)|update both delivery and inventoryEvent record

## Queries
### (1) getInventoryEvents
PreScript
```cue
context.args.input
```
Query
```graphql
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
}
```

### (2) updateRecords
PreScript
```cue
{
  "deliveryID": args.collection[0].delivery.id,
  "orderID": args.collection[0].delivery.orderID,
  "productID": args.collection[0].delivery.productID,
  "locationID": args.collection[0].delivery.locationID,
  "qty": args.collection[0].delivery.quantity,
  "negativeQty": -args.collection[0].delivery.quantity,
  "snapshotDate": context.args.input.deliveryDate
}
```
Query
```graphql
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
}
```

# editOrder
Edit order.

## Pipelines
|Name|Description
|----|-----
(1) [getRecords](#1-getRecords)|update SALES order record
(2) [updateOrder](#2-updateOrder)|update order records

## Queries
### (1) getRecords
PreScript
```cue
context.args.input
```
Query
```graphql
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
               }
```

### (2) updateOrder
PreScript
```cue
             {
               "deliveryID": args.deliveries.collection[0].id,
               "orderID": context.args.input.orderID,
               "productID": context.args.input.productID,
               "locationID": context.args.input.locationID,
               "qty": context.args.input.quantity,
               "negativeQty": -context.args.input.quantity,
               "inventoryEventID": args.inventoryEvents.collection[0].id
             }
```
Query
```graphql
               mutation editOrder(
                 $deliveryID: ID!
                 $orderID: ID!
                 $productID: ID!
                 $locationID: ID
                 $qty: Int!
                 $negativeQty: Int!
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
                     quantity: $negativeQty
                     productID: $productID
                     locationID: $locationID
                   }
                 ) {
                   id
                 }
               }
```

# editPurchase
Edit purchase order.

## Pipelines
|Name|Description
|----|-----
(1) [getRecords](#1-getRecords)|get order records
(2) [updateOrder](#2-updateOrder)|update order records

## Queries
### (1) getRecords
PreScript
```cue
context.args.input
```
Query
```graphql
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
               }
```

### (2) updateOrder
PreScript
```cue
             {
               "deliveryID": args.deliveries.collection[0].id,
               "orderID": context.args.input.orderID,
               "productID": context.args.input.productID,
               "locationID": context.args.input.locationID,
               "qty": context.args.input.quantity,
               "inventoryEventID": args.inventoryEvents.collection[0].id
             }
```
Query
```graphql
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
               }
```

# placeOrder

Place order.

## Pipelines
|Name|Description
|----|-----
(1) [createOrder](#1-createOrder)|create order record as SALES
(2) [createDelivery](#2-createDelivery)|create delivery record
(3) [createInventoryEvent](#3-createInventoryEvent)|create inventoryEvent record

## Queries
### (1) createOrder
PreScript
```cue
context.args.input
```
Query
```graphql
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
```

### (2) createDelivery
PreScript
```cue
             {
               "quantity": context.args.input.quantity,
               "deliveryDate": context.args.input.placedDate,
               "productID": context.args.input.productID,
               "locationID": context.args.input.locationID,
               "orderID": args.id
             }
```
Query
```graphql
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
               }
```

### (3) createInventoryEvent
PreScript
```cue
             {
               "negativeQty": -context.args.input.quantity,
               "snapshotDate": context.args.input.placedDate,
               "productID": context.args.input.productID,
               "locationID": context.args.input.locationID,
               "orderID": args.orderID,
               "deliveryID": args.id
             }
```
Query
```graphql
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
               }
```

# placePurchase

Place purchase.

## Pipelines
|Name|Description
|----|-----
(1) [createOrder](#1-createOrder)|create order record as PURCHASE
(2) [createDelivery](#2-createDelivery)|create delivery record
(3) [createInventoryEvent](#3-createInventoryEvent)|create inventoryEvent record

## Queries
### (1) createOrder
PreScript
```cue
context.args.input
```
Query
```graphql
  mutation createOrder($quantity: Int, $placedDate: Date, $productID: ID) {
    createOrder(
      input: {
        quantity: $quantity
        orderType: PURCHASE
        placedDate: $placedDate
        productID: $productID
      }
    ) {
      id
    }
  }
```

### (2) createDelivery
PreScript
```cue
             {
               "quantity": context.args.input.quantity,
               "deliveryDate": context.args.input.placedDate,
               "productID": context.args.input.productID,
               "locationID": context.args.input.locationID,
               "orderID": args.id
             }
```
Query
```graphql
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
                     deliveryType: INCOMING
                     deliveryDate: $deliveryDate
                     productID: $productID
                     locationID: $locationID
                     deliveryState: UNDISPATCHED
                   }
                 ) {
                   id
                   orderID
                 }
               }
```

### (3) createInventoryEvent
PreScript
```cue
             {
               "quantity": context.args.input.quantity,
               "snapshotDate": context.args.input.placedDate,
               "productID": context.args.input.productID,
               "locationID": context.args.input.locationID,
               "orderID": args.orderID,
               "deliveryID": args.id
             }
```
Query
```graphql
               mutation createInventoryEvent(
                 $quantity: Int!
                 $snapshotDate: Date!
                 $productID: ID!
                 $locationID: ID!
                 $orderID: ID
                 $deliveryID:ID
               ) {
                 createInventoryEvent(
                   input: {
                     orderID: $orderID
                     quantity: $quantity
                     productID: $productID
                     locationID: $locationID
                     snapshotDate:$snapshotDate
                     deliveryID:$deliveryID
                     deliveryState: UNDISPATCHED
                   }
                 ) {
                   id
                 }
               }
```

# transferInventory

Transfer inventory between locations.

## Pipelines
|Name|Description
|----|-----
(1) [createDelivery](#1-createDelivery)|create deliveries for transfer
(2) [createInventoryEvents](#2-createInventoryEvents)|create inventory events for transfer

## Queries
### (1) createDelivery
PreScript
```cue
context.args.input
```
Query
```graphql
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
}
```

### (2) createInventoryEvents
PreScript
```cue
{
  "qty": context.args.input.quantity,
  "negativeQty": -context.args.input.quantity,
  "deliveryDate": context.args.input.deliveryDate,
  "productID": context.args.input.productID,
  "transferOutID": context.args.input.transferOutID,
  "transferInID": context.args.input.transferInID,
  "transferInDeliveryID": args.transferIn.id,
  "transferOutDeliveryID": args.transferOut.id
}
```
Query
```graphql
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
}
```
