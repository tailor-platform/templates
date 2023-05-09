# Overview
This SCM application has 4 types:
- Delivery: This type stores delivery data.
- Product: This type stores product master data.
- Order: This type stores order data.
- Location: This type stores location master data, which explains where to deliver the product.




## Sample mutations
Create new product
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
Create new sales order
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

Create new delivery
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


## Dev instructions

### Deployment

To create the application, see the [Quickstart](https://pf-services-docs-tailorinc.vercel.app/getting-started/quickstart)

### Seeding

To seed the data do:

```sh
tailorctl app login -u ${username} -p ${password}
tailorctl app import -m charts
```

## Apps in Retool FIXME, once publish the app, we have to update the link.  

