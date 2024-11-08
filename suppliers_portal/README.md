# Supplier Portal

## Overview

This template provides a comprehensive solution for managing RFQ process.
This application supports both Buyer and Supplier use case.


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
cd suppliers_portal
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
    Supplier {
        string code
        string name
        string companyName
        string contactNumber
        string email
        string address
        enum status
        uuid userID
        datetime createdAt
    }
    Product {
        string code
        string name
        string description
        float price
        string uom
        datetime createdAt
    }
    User {
        string name
        string email
        uuid[] roles
        datetime createdAt
        datetime updatedAt
    }
    Role {
        string name
        datetime createdAt
        datetime updatedAt
    }
    AdvanceShipmentNotice {
        date asnDate
        string reference
        Invoice invoice
        uuid invoiceID
        Supplier supplier
        uuid supplierID
        string trackingNumber
        string carrier
        date shipmentDate
        date expectedDeliveryDate
        integer containerQuantity
        float weight
        enum status
        date submittedOn
        datetime createdAt
    }
    AdvanceShipmentNoticeLineItem {
        integer displayOrder
        AdvanceShipmentNotice advanceShipmentNotice
        uuid advanceShipmentNoticeID
        InvoiceLineItem invoiceLineItem
        uuid invoiceLineItemID
        Product product
        uuid productID
        float quantity
        string description
    }
    GoodsReceivedNote {
        date grnDate
        string reference
        Invoice invoice
        uuid invoiceID
        Supplier supplier
        uuid supplierID
        AdvanceShipmentNotice advanceShipmentNotice
        uuid advanceShipmentNoticeID
        enum status
        datetime createdAt
    }
    GoodsReceivedNoteLineItem {
        integer displayOrder
        GoodsReceivedNote goodsReceivedNote
        uuid goodsReceivedNoteID
        InvoiceLineItem invoiceLineItem
        uuid invoiceLineItemID
        AdvanceShipmentNoticeLineItem advanceShipmentNoticeLineItem
        uuid advanceShipmentNoteLineItemID
        Product product
        uuid productID
        float quantity
        string description
    }
    Invoice {
        Supplier supplier
        uuid supplierID
        PurchaseOrder purchaseOrder
        uuid purchaseOrderID
        date invoiceDate
        date dueDate
        string reference
        enum status
        date submittedOn
        date voidedOn
        date shippedOn
        datetime createdAt
        datetime updatedAt
    }
    InvoiceLineItem {
        integer displayOrder
        Invoice invoice
        uuid invoiceID
        Product product
        uuid productID
        PurchaseOrderLineItem purchaseOrderLineItem
        uuid purchaseOrderLineItemID
        string description
        float price
        float quantity
        float total
    }
    RequestForQuote {
        date rfqDate
        date deadline
        string description
        string reference
        enum status
        datetime createdAt
    }
    RequestForQuoteLineItem {
        integer displayOrder
        RequestForQuote requestForQuote
        uuid requestForQuoteID
        Product product
        uuid productID
        string description
        float quantity
    }
    RequestForQuoteSupplier {
        RequestForQuote requestForQuote
        uuid requestForQuoteID
        Supplier supplier
        uuid supplierID
        Quote quote
        uuid quoteID
        datetime createdAt
    }
    Quote {
        Supplier supplier
        uuid supplierID
        RequestForQuote requestForQuote
        uuid requestForQuoteID
        date quoteDate
        date expiryDate
        string reference
        enum status
        datetime createdAt
    }
    QuoteLineItem {
        integer displayOrder
        Quote quote
        uuid quoteID
        RequestForQuoteLineItem requestForQuoteLineItem
        uuid requestForQuoteLineItemID
        Product product
        uuid productID
        string description
        float price
        float quantity
        float total
    }
    PurchaseOrder {
        Supplier supplier
        uuid supplierID
        Quote quote
        uuid quoteID
        date purchaseOrderDate
        string reference
        enum status
        date submittedOn
        date confirmedOn
        date rejectedOn
        date canceledOn
        enum canceledBy
        date completedOn
        datetime createdAt
    }
    PurchaseOrderLineItem {
        integer displayOrder
        PurchaseOrder purchaseOrder
        uuid purchaseOrderID
        Product product
        uuid productID
        QuoteLineItem quoteLineItem
        uuid quoteLineItemID
        string description
        float price
        float quantity
        float total
    }
    TimelineEntry {
        uuid sourceID
        string sourceType
        string eventName
        enum eventType
        string objectType
        uuid objectID
        messageSegments[] messageSegments
        datetime createdAt
    }

    Supplier ||--o{ AdvanceShipmentNotice : supplier
    Invoice ||--o{ AdvanceShipmentNotice : invoice
    AdvanceShipmentNotice ||--o{ AdvanceShipmentNoticeLineItem : advanceShipmentNotice
    InvoiceLineItem ||--o{ AdvanceShipmentNoticeLineItem : invoiceLineItem
    Product ||--o{ AdvanceShipmentNoticeLineItem : product
    Supplier ||--o{ GoodsReceivedNote : supplier
    Invoice ||--o{ GoodsReceivedNote : invoice
    AdvanceShipmentNotice ||--o{ GoodsReceivedNote : advanceShipmentNotice
    GoodsReceivedNote ||--o{ GoodsReceivedNoteLineItem : goodsReceivedNote
    InvoiceLineItem ||--o{ GoodsReceivedNoteLineItem : invoiceLineItem
    AdvanceShipmentNoticeLineItem ||--o{ GoodsReceivedNoteLineItem : advanceShipmentNoticeLineItem
    Product ||--o{ GoodsReceivedNoteLineItem : product
    Supplier ||--o{ Invoice : supplier
    PurchaseOrder ||--o{ Invoice : purchaseOrder
    Invoice ||--o{ InvoiceLineItem : invoice
    Product ||--o{ InvoiceLineItem : product
    PurchaseOrderLineItem ||--o{ InvoiceLineItem : purchaseOrderLineItem
    RequestForQuote ||--o{ RequestForQuoteLineItem : requestForQuote
    Product ||--o{ RequestForQuoteLineItem : product
    RequestForQuote ||--o{ RequestForQuoteSupplier : requestForQuote
    Supplier ||--o{ RequestForQuoteSupplier : supplier
    Quote ||--o{ RequestForQuoteSupplier : quote
    Supplier ||--o{ Quote : supplier
    RequestForQuote ||--o{ Quote : requestForQuote
    Quote ||--o{ QuoteLineItem : quote
    RequestForQuoteLineItem ||--o{ QuoteLineItem : requestForQuoteLineItem
    Product ||--o{ QuoteLineItem : product
    Supplier ||--o{ PurchaseOrder : supplier
    Quote ||--o{ PurchaseOrder : quote
    PurchaseOrder ||--o{ PurchaseOrderLineItem : purchaseOrder
    Product ||--o{ PurchaseOrderLineItem : product
    QuoteLineItem ||--o{ PurchaseOrderLineItem : quoteLineItem
    User ||--o{ Role : roles
```

