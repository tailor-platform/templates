# Client Portal

This template provides the building blocks for a Client Portal application.

With this template you can craft client and manager facing pages.

Clients can for instance:
- Open new service requests and track their status.
- See their open and completed service requests.
- See due and paid invoices.

Managers can for instance:
- See all the customers, service requests, and invoices.
- See detailed information for each customer.
- Complete service requests and create invoices.


## Overview

This application has 3 types:
- Client: An end user that opens service requests and gets invoiced.
- Request: A service request that contains a description, kind (hardware, networking, ...), and system (pc, mac, ...).
- Invoice: A basic invoice representation that features an amount and status. Associated with both Client and Request types.

Note this template is intentionally kept very simple.
For instance, for more advanced state and approval chain management you may want to leverage the [StateFlow](https://docs.tailor.tech/tutorials/setup-stateflow/overview) service.


### Sample GraphQL queries and mutations

#### Client-facing pages

Get a client's opened service requests:
```graphql
query($clientId: ID) {
  requests(query: { clientId: { eq: $clientId }, status: { eq: "OPEN" }}) {
    collection {
      id
      description
      kind
      system
    }
  }
}
```

Get a client's invoices:
```graphql
query($clientId: ID) {
  invoices(query: { clientId: { eq: $clientId } }) {
    collection {
      id
      status
      amount
      request {
        id
        description
      }
    }
  }
}
```

Open a new service request:
```graphql
mutation($clientId: ID!, $description: String, $kind: Kind!, $system: System!) {
  createRequest(
    input: {
      clientId: $clientId,
      description: $description,
      kind: $kind,
      system: $system
    }
  ) {
    id
  }
}
```

#### Manager-facing pages

Get all opened requests alongside basic client information:
```graphql
query {
  requests(query:{status: { eq: "OPEN" }}) {
    collection {
      id
      description
      kind
      system
      status
      client {
        id
        user {
          displayName
        }
      }
    }
  }
}
```

Get all invoices with basic request and client information:
```graphql
query {
  invoices {
    collection {
      id
      status
      amount
      request {
        id
        description
      }
      client {
        id
        user {
          displayName
        }
      }
    }
  }
}
```

Complete a service request and create an invoice simultaneously:
```graphql
mutation($clientId: ID!, $requestId: ID!, $amount: Int) {
  updateRequest(id: $requestId, input: { status: "COMPLETED" }) {
    id
  }

  createInvoice(
    input: {
      clientId: $clientId,
      requestId: $requestId,
      amount: $amount
    }
  ) {
    id
  }
}
```


## Dev instructions

### Preparation

Before anything, change the seed UUID in [values.example.yaml](values.example.yaml):

```yaml
seed:
  key: "<newly generated UUID here>"
```

### Deployment

To create the application, see the [Quickstart](https://pf-services-docs-tailorinc.vercel.app/getting-started/quickstart)

### Seeding

To seed the data do:

```sh
tailorctl app login -u <username> -p <password>
tailorctl app import -m charts/graphql_seed.cue
```


## Apps in Retool

- [Client view](https://tailorinc.retool.com/apps/0b249efc-de53-11ed-a861-63b9cb6368eb/app%20templates/Client%20Portal%20(client%20view)
- [Manager view](https://tailorinc.retool.com/apps/68bcf0f0-c166-11ed-a96f-dbc7e6501446/app%20templates/Client%20Portal%20(manager%20view))

