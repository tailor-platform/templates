## Overview
This invoice application has 2 types:

- `invoice`: This type stores data about an invoice.
- `state`: This type stores the state of your business flow and extends the `state` type in the [Stateflow service](https://platform-frontend-services-docs.vercel.app/guides/stateflow). By extending the `state` in tailor DB, an invoice can have a `state` in its field. The actual data is managed by the [Stateflow service](https://platform-frontend-services-docs.vercel.app/guides/stateflow).


### Invoice review status transition
```mermaid
flowchart LR
    ManagerReview --> CustomerReview --> AllApproved
```
Once you create an invoice, you can initiate the business operation to let the manager and customer review the invoice with the `reviewInvoice` mutation. When the review process is initiated, the review state becomes `ManagerReview`.  
At this state, users who have either a Manager or Staff role can read the invoice, and only users who have a Manager role can update the invoice. Also, the manager can only approve the invoice with the `approveInvoice` mutation.  
If the manager approves the invoice, the state will be updated to `CustomerReview` from `ManagerReview`. At this state, users who have a customer role can approve the invoice. When the customer approves the invoice, the review process is done, and the state becomes `AllApproved`. At this state, the invoice record will be read-only, and no more updates are applicable.


### Sample GraphQL queries and mutations

Create a new invoice record.
```graphql
mutation ($invoiceName: String!, $quote: Int!) {
  createInvoice(input: { invoiceName: $invoiceName, quote: $quote }) {
    id
  }
}
```

Initiate a review process for an invoice.
```graphql
mutation ($invoiceID: ID!) {
  reviewInvoice(input: { invoiceID: $invoiceID }) {
    id
  }
}
```

Approve an invoice to proceed a review.
```graphql
mutation ($invoiceID: ID!, $stateID: ID!) {
  approveInvoice(input: { stateID: $stateID, invoiceID: $invoiceID }) {
    success
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

