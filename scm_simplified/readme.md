# Simplified SCM

## Overview
This SCM application has 4 types:
- Delivery: This type stores delivery data.
- Product: This type stores product master data.
- Order: This type stores order data.
- Location: This type stores location master data, which explains where to deliver the product.


## Usage

To deploy this template, please refer to the instructions [here](https://www.tailor.tech/templates/simplescm).

To learn more about the files provided in this template, please refer to the [Tailor Platform documentation](https://docs.tailor.tech/).


## Demo application

A demo application that utilizes this template is available [here](https://tailorinc.retool.com/embedded/public/dcd12d76-f3b4-44fd-b0e9-8733e116cdac).


## Sample mutations

Create a new product:
```graphql
mutation createProduct(
  $productName: String
  $productCode: Int
  $productCategory: String
  $pricePerUnit: Int
  $eanCode: String
  $uom: String
) {
  createProduct(
    input: {
      productName: $productName
      pricePerUnit: $pricePerUnit
      eanCode: $eanCode
      productCode: $productCode
      uom: $uom
      productCategory: $productCategory
    }
  ) {
    id
  }
}
```

Create a new sales order:
```graphql
mutation createOrderSales(
  $productID: ID,
  $orderType: OrderType!,
  $placedDate: Date,
  $quantity: Int
) {
  createOrder(
    input: {
      productID: $productID,
      orderType: $orderType,
      placedDate: $placedDate,
      quantity: $quantity
    }
  ) {
    id
    productID
    orderType
    placedDate
    quantity
  }
}
```

Create a new delivery:
```graphql
mutation createDelivery(
  $orderID: ID,
  $quantity: Int,
  $deliveryDate: Date,
  $locationID: ID,
  $productID: ID,
  $deliveryType: DeliveryType!
) {
  createDelivery(
    input: {
      productID: $productID,
      orderID: $orderID,
      quantity: $quantity,
      deliveryDate: $deliveryDate,
      locationID: $locationID,
      deliveryType: $deliveryType
    }
  ) {
    id
    orderID
    quantity
    deliveryDate
    locationID
    deliveryType
    version
    versions
  }
}
```
