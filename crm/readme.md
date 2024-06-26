# CRM

## Overview
This CRM application has 5 types:

- customerAccount: This type stores data about the customer accounts.
- engagement: This type stores data about interactions between the employees and the customers, such as calls or emails.
- lead: This type stores data about potential customers who have shown interest in the business's products or services.
- transaction: This type stores data about sales transactions made by the customer accounts.
- user: This type stores data about the users of the tailor platform.

In this application, the customer data is managed by the customerAccount records, while potential customer data is managed by the lead records.
The engagement records store data about interactions between the business and its customers, while the transaction records store data about actual transactions of customer accounts.

If you want to query the data to analyze customer behavior or sales performance, you can use appropriate queries on the respective record types.


## Usage
To deploy this template, run the following commands

```
make init
make apply
make seed
```
 
To gain further insight into the data structure, visit the [Tailor Console](https://console.tailor.tech) and explore the data schema using live sample data.

## Demo application

A demo application that utilizes this template is available [here](https://tailorinc.retool.com/embedded/public/ea42df32-d6f6-45c5-84c8-cac994586440).


## Sample GraphQL queries and mutations

Create a lead record.
```graphql
mutation createLead(
  $companyName: String
  $phoneNum: String
  $email: String
  $dealAmt: String
  $contactName: String
  $leadSource:String
) {
  createLead(
    input: {
      companyName: $companyName
      dealAmount: $dealAmt
      leadSource: $leadSource
      contact: {
        contactName: $contactName
        emailAddress: $email
        phoneNumber: $phoneNum
      }
    }
  ) {
    id
  }
}
```

Get leads records per lead's `stage` and `companyName`
```graphql
query leads ($stage:Stage, $companyName:String) {
  leads(query: {stage: {eq: $stage},companyName: {contains: $companyName} } ) {
    collection {
      id
      companyName
      stage
      leadSource
      dealAmount
      contact{
        contactName
        emailAddress
        phoneNumber
      }
    }
  }
}
```
Convert a lead record to Account record
```graphql
mutation convertAccount(
  $leadID: ID!
  $companyName: String!
  $contactName: String
  $emailAddress: String
  $phoneNumber: String
) {
  convertAccount(
    leadID: $leadID
    companyName: $companyName
    contactName: $contactName
    emailAddress: $emailAddress
    phoneNumber: $phoneNumber
  )
}
```
