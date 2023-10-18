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


## Usage
To deploy this template, please refer to the instructions in the [console](https://console.tailor.tech/).

To seed the initial data for your application, run these commands.
```bash
tailorctl app login -u '$owner_username' -p '$owner_password' #your workspace owner name and password
tailorctl app import -m charts --auto-approve
tailorctl app login -u 'todo_app_stateflow_admin' -p 'todo_app_stateflow_admin'
tailorctl app import -m charts/seed --auto-approve
```

## Demo application

Access a demo application that utilizes this template and showcases various user views through the following links:

- [Client view](https://tailorinc.retool.com/embedded/public/2c3d2e8a-a0d6-4089-ab66-868027990c97)
- [Manager view](https://tailorinc.retool.com/embedded/public/c8559c74-98e2-45aa-bd3d-56401c871458)


## Sample GraphQL queries and mutations

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
