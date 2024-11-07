# Warehouse Management

## Overview

This template provides a comprehensive solution for managing inventory items among the warehouse.
This application supports both Admin and Warehouse worker use case.
For more details please visit [here](https://www.tailor.tech/templates/wh-mgmt-hub).


## Deploy the app template

To deploy our app templates, you need tailorctl and a Tailor account.  
If you don’t have a Tailor account,
please [contact us](https://form.typeform.com/to/QONhVIuj?typeform-source=www.tailor.tech).

### Prerequisites

To install tailorctl and other dependencies, you can use homebrew.

```
brew install tailor-platform/tap/tailorctl
brew install coreutils yq cue gh
```

For more details, please visit our [documentation](https://docs.tailor.tech/getting-started/quickstart).

To get started with our app templates follow the steps below:

## Quick Start

### 1. Clone our app templates and install dependencies

```bash
git clone git@github.com:tailor-platform/templates.git
cd templates
pnpm i
```

### 2. Choose an app template

```bash
cd warehouse_management
```

### 3. Run the following commands to deploy the app

```bash
tailorctl workspace create -i # follow the interactive prompt
make init
make apply
make seed
```

### 4. Get the access token to use the GraphQL API in the playground

```bash
make machine-token
```

Please set the token in the Headers section of the playground as follows:
```json
{
  "Authorization": "bearer ${your_access_token}"
}
```

### 5. Finally, open the GraphQL playground to run queries

```
make app
```


## ERD for this application
```mermaid
erDiagram
%% Bin
Bin {
    uuid warehouseID
    integer barcode
    string shelf
    boolean isDefault
}

%% BinStock
BinStock {
    uuid binID
    uuid productID
    integer quantity
}

%% Product
Product {
    string code
    string brand
    string style
    string category
    float cost
    float msrp
    string uom
    date sellingStartDate
}

%% Store
Store {
    integer code
    string name
    string address
    string type
    string contactNumber
}

%% Supplier
Supplier {
    integer code
    string name
    string contactNumber
    string email
    string address
}

%% Warehouse
Warehouse {
    integer code
    string name
    string address
    string type
    string contactNumber
}

%% PurchaseOrder
PurchaseOrder {
    uuid warehouseID
    uuid supplierID
    date purchaseOrderDate
}

%% PurchaseOrderLineItem
PurchaseOrderLineItem {
    uuid productID
    uuid purchaseOrderID
    integer quantity
}

%% PutAway
PutAway {
    uuid purchaseOrderID
    date putAwayDate
}

%% PutAwayLineItem
PutAwayLineItem {
    uuid putAwayID
    uuid productID
    uuid binID
    integer quantity
}

%% SalesOrder
SalesOrder {
    uuid storeID
    date salesOrderDate
}

%% SalesOrderLineItem
SalesOrderLineItem {
    uuid productID
    uuid salesOrderID
    integer quantity
}

%% ShipOut
ShipOut {
    uuid salesOrderID
    date shipOutDate
}

%% ShipOutLineItem
ShipOutLineItem {
    uuid shipOutID
    uuid productID
    uuid binID
    integer quantity
}

BinStock ||--o{ Bin : binID
BinStock ||--o{ Product : productID

PurchaseOrder ||--o{ Warehouse : warehouseID
PurchaseOrder ||--o{ Supplier : supplierID

PurchaseOrderLineItem ||--o{ Product : productID
PurchaseOrderLineItem ||--o{ PurchaseOrder : purchaseOrderID

PutAway ||--o{ PurchaseOrder : purchaseOrderID

PutAwayLineItem ||--o{ PutAway : putAwayID
PutAwayLineItem ||--o{ Product : productID
PutAwayLineItem ||--o{ Bin : binID

SalesOrder ||--o{ Store : storeID

SalesOrderLineItem ||--o{ Product : productID
SalesOrderLineItem ||--o{ SalesOrder : salesOrderID

ShipOut ||--o{ SalesOrder : salesOrderID

ShipOutLineItem ||--o{ ShipOut : shipOutID
ShipOutLineItem ||--o{ Product : productID
ShipOutLineItem ||--o{ Bin : binID
```

