# CRM

## Overview

This template provides a comprehensive solution for managing customer relationships. It is designed to support the management of pipelines, stages, leads, and deals.

## Usage
To deploy this template, run the following commands

```
make init
make apply
```

To gain further insight into the data structure, visit the [Tailor Console](https://console.tailor.tech) and explore the data schema using live sample data.

## Seed the initial data

1. Install dependencies in the templates folder

```
pnpm i
```

2. To seed the initial data into a deployed application run the following commands:

```bash
cd crm
node ../common/scripts/seed.mjs
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
