# Omakase Demo

## Demo Prep

After you deployed the app, please follow these steps to set up the state to accept the Sales Order from Shopify.

1. Deployment
   make init
   make apply

2. Set up Inventory
   make demo

Now, you have 100 available quantity for each of these product.
Product variants ID will be same.

```json
    "productVariants": {
      "edges": [
        {
          "node": {
            "id": "52b9942c-5565-5689-ae3b-589121a87da9",
            "displayName": "Ace Iconic Performance Hat - Black / OS / Plain",
          }
        },
        {
          "node": {
            "id": "fe802937-0960-5efa-8f57-27ebfeb144ca",
            "displayName": "Ace Iconic Performance Hat - Light Slate / OS / Plain",
          }
        }
      ]
    },
```

https://admin.shopify.com/store/avid-ims-dev-store/products/7543109287972
You can create sales orders in Shopify for these products.

Once the sales order is created in Shopify, it will be automatically synced with the demo application. (you need to set up the variables)
https://pipedream.com/@tailor-partners/projects/proj_e5s0XjB/tree

If you create the sales order, you can create a shipment from the sales order with this GQL.

```gql
mutation ($salesOrderID: ID!) {
  createShipmentFromSalesOrder(input: { salesOrderID: $salesOrderID }) {
    shipmentId
  }
}
```

If you want to update the inventory state, please run this GQL.
You have to run `HOLD` first.

```gql
mutation ($shipmentItemIDs: [ID]!) {
  createStockEventsFromShipmentLineItems(
    input: { shipmentItemIDs: $shipmentItemIDs, action: HOLD }
  )
}
```

Then `SHIP`

```gql
mutation ($shipmentItemIDs: [ID]!) {
  createStockEventsFromShipmentLineItems(
    input: { shipmentItemIDs: $shipmentItemIDs, action: SHIP }
  )
}
```

once you make it `SHIP`, you can push the inventory change to Shopify.

```sh
curl -X POST https://eooueqea9ac07t5.m.pipedream.net \
     -H "Content-Type: application/json" \
     -d '{
           "variables": {
             "variantID": "52b9942c-5565-5689-ae3b-589121a87da9"
           }
         }'
```

## Data Reset

You can run these command if you want to reset data for Demo.
This will delete all of the data for these Types.

IMS:

```
tailorctl workspace service tailordb truncate -n mo-dev -t InventoryItem -a
tailorctl workspace service tailordb truncate -n mo-dev -t InventoryLevel -a
tailorctl workspace service tailordb truncate -n mo-dev -t PurchaseOrder -a
tailorctl workspace service tailordb truncate -n mo-dev -t PurchaseOrderLineItem -a
tailorctl workspace service tailordb truncate -n mo-dev -t Receipt -a
tailorctl workspace service tailordb truncate -n mo-dev -t ReceiptLineItem -a
tailorctl workspace service tailordb truncate -n mo-dev -t SalesOrder -a
tailorctl workspace service tailordb truncate -n mo-dev -t SalesOrderLineItem -a
tailorctl workspace service tailordb truncate -n mo-dev -t Shipment -a
tailorctl workspace service tailordb truncate -n mo-dev -t ShipmentLineItem -a
tailorctl workspace service tailordb truncate -n mo-dev -t StockSummary -a
tailorctl workspace service tailordb truncate -n mo-dev -t OperationalStockEvent -a
tailorctl workspace service tailordb truncate -n mo-dev -t Contact -a
```

MO:

```
tailorctl workspace service tailordb truncate -n mo-dev -t Uom -a
tailorctl workspace service tailordb truncate -n mo-dev -t UomConversion -a
tailorctl workspace service tailordb truncate -n mo-dev -t Item -a
tailorctl workspace service tailordb truncate -n mo-dev -t Bom -a
tailorctl workspace service tailordb truncate -n mo-dev -t BomLineItem -a
tailorctl workspace service tailordb truncate -n mo-dev -t Employee -a
tailorctl workspace service tailordb truncate -n mo-dev -t WorkingHour -a
tailorctl workspace service tailordb truncate -n mo-dev -t DailySchedule -a
tailorctl workspace service tailordb truncate -n mo-dev -t WorkCenter -a
tailorctl workspace service tailordb truncate -n mo-dev -t Operation -a
tailorctl workspace service tailordb truncate -n mo-dev -t MOBatch -a
tailorctl workspace service tailordb truncate -n mo-dev -t ManufacturingOrder -a
tailorctl workspace service tailordb truncate -n mo-dev -t MOLineItem -a
tailorctl workspace service tailordb truncate -n mo-dev -t OperationDependency -a
tailorctl workspace service tailordb truncate -n mo-dev -t WorkOrder -a
tailorctl workspace service tailordb truncate -n mo-dev -t WorkOrderDependency -a
tailorctl workspace service tailordb truncate -n mo-dev -t Item -a
tailorctl workspace service tailordb truncate -n mo-dev -t WorkOrderTransition -a
tailorctl workspace service tailordb truncate -n mo-dev -t Role -a
tailorctl workspace service tailordb truncate -n mo-dev -t User -a
```
