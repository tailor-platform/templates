# Purchase Order / Sales Order

## Overview

This template provides a comprehensive solution for managing Purchase and Sales orders.
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
cd poso
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
    StockHistory {
        Product product
        uuid productID
        integer totalQuantity
        float totalCost
        float averageCost
        datetime createdAt
        datetime updatedAt
    }
    StockSummary {
        Product product
        uuid productID
        integer totalQuantity
        float totalCost
        float averageCost
        datetime createdAt
        datetime updatedAt
    }
    User {
        string name
        string email
        uuid[] roles
        datetime createdAt
        datetime updatedAt
    }
    DocumentStatus {
        string name
        uuid documentTypeID
        DocumentType documentType
        boolean isEditable
        boolean triggersStockEvent
        toStates[] toStates
        boolean inactive
        datetime createdAt
        datetime updatedAt
    }
    DocumentTemplate {
        string name
        string dateLabel
        boolean inactive
        datetime createdAt
        datetime updatedAt
    }
    DocumentType {
        string name
        uuid defaultDocumentStatusID
        DocumentStatus defaultDocumentStatus
        boolean inactive
        datetime createdAt
        datetime updatedAt
    }
    Product {
        string name
        float unitCost
        float unitPrice
        string uom
        string costCategory
        uuid taxID
        Tax tax
        enum inventoryType
        boolean recalculatedLineItem
        boolean inactive
        datetime createdAt
        datetime updatedAt
    }
    Contact {
        string name
        boolean isCustomer
        boolean isVendor
        boolean inactive
        string billingEmail
        string billingAddress
        datetime createdAt
        datetime updatedAt
    }
    Role {
        string name
        datetime createdAt
        datetime updatedAt
    }
    Tax {
        string name
        float taxRate
        boolean inactive
        datetime createdAt
        datetime updatedAt
    }
    Document {
        DocumentType documentType
        uuid documentTypeID
        DocumentTemplate documentTemplate
        uuid documentTemplateID
        Contact contact
        uuid contactID
        string code
        date date
        uuid documentStatusID
        DocumentStatus documentStatus
        date paymentDueDate
        float paymentAmount
        float subtotalAmount
        float subtotalCost
        float taxAmount
        float totalAmount
        boolean isCalculated
        boolean inactive
        datetime createdAt
        datetime updatedAt
    }
    LineItem {
        Document document
        uuid documentID
        Product product
        uuid productID
        uuid taxID
        Tax tax
        integer quantity
        string name
        float unitCost
        float unitPrice
        float markup
        float subtotalCost
        float subtotalAmount
        float taxAmount
        float totalAmount
        boolean isCalculated
        boolean inactive
        datetime createdAt
        datetime updatedAt
    }
    StockEvent {
        uuid productID
        Product product
        float unitCost
        integer incrementalQuantity
        uuid documentID
        Document document
        float transactionTotalCost
        integer totalQuantity
        float totalCost
        float averageCost
        datetime createdAt
        datetime updatedAt
    }


    Product ||--o{ StockHistory : product
    Product ||--o{ StockSummary : product
    User ||--o{ Role : roles
    DocumentType ||--o{ DocumentStatus : documentType
    DocumentStatus ||--o{ DocumentStatus : toStates
    DocumentStatus ||--o{ DocumentType : defaultDocumentStatus
    Tax ||--o{ Product : tax
    DocumentType ||--o{ Document : documentType
    DocumentTemplate ||--o{ Document : documentTemplate
    Contact ||--o{ Document : contact
    DocumentStatus ||--o{ Document : documentStatus
    Document ||--o{ LineItem : document
    Product ||--o{ LineItem : product
    Tax ||--o{ LineItem : tax
    Product ||--o{ StockEvent : product
    Document ||--o{ StockEvent : document
```

