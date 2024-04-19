# warehouse management

## Overview
Features

## Database Schema
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

## Usage
WIP

To seed the initial data for your application, run these commands.
```bash
tailorctl app login -u '$owner_username' -p '$owner_password' #your workspace owner name and password
tailorctl app import -m charts --auto-approve
```






