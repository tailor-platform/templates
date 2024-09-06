# CRM

## Overview

This template provides a comprehensive solution for managing customer relationships. It is designed to support the management of pipelines, stages, leads, and deals.
You can see the sample frontend application [here](https://www.tailor.tech/templates/crm).

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
cd crm
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

## Sample GraphQL queries and mutations

Create a user with company
```graphql
mutation ($input: ContactWithCompanyCreateInput!) {
    createContactWithCompany (input: $input) {
		contactID
		companyID
	}
}
```

Get Deals Worth by Stages
```graphql
query dealsWon($ID: [ID]) {
  aggregateDeals(query: { dealStageId: { in: $ID } }) {
    sum {
      value
    }
  }
}
```

Get Deals Worth by User in Specified Stages
```graphql
query dealsByUserInStages($ID: [ID]) {
  aggregateDeals(query: { dealStageId: { nin: $ID } }) {
    groupBy {
      userId
    }
    sum {
      value
      amount
    }
  }
}
```

## ERD for this application
```mermaid
erDiagram

%% Relationships
Deal ||--o{ DealPipeline : "belongs to"
Deal ||--o{ DealPipelineStage : "is in"
Deal ||--o{ User : "owned by"
DealContact ||--o{ Deal : "belongs to"
DealContact ||--o{ Contact : "involves"
DealCompany ||--o{ Deal : "for"
DealCompany ||--o{ Company : "related to"
ContactListMember ||--o{ Contact : "includes"
ContactListMember ||--o{ ContactList : "part of"
DealPipelineStage ||--o{ DealPipeline : "part of"
EngagementDeal ||--o{ Deal : "related to"
EngagementDeal ||--o{ Engagement : "includes"
EngagementContact ||--o{ Contact : "related to"
EngagementContact ||--o{ Engagement : "includes"
EngagementCompany ||--o{ Company : "related to"
EngagementCompany ||--o{ Engagement : "includes"
TeamUser ||--o{ Team : "part of"
TeamUser ||--o{ User : "includes"
EngagementEmail ||--o{ Engagement : "related to"
EngagementNote ||--o{ Engagement : "related to"
EngagementTask ||--o{ Engagement : "related to"

```