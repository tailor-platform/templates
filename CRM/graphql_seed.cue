package graphqlseed

import (
  "github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
  "uuid"
  "crypto/hmac"
)

#seed: uuid.FromInt(1680674)

manifest.#TailorManifest & {
  version: "v1"
  kind:    manifest.#KindGraphqlSeed
  spec:    manifest.#SpecGraphqlSeed & {
    mutations: [
      {
        query: """
            mutation ($accountID:ID) {
              CustomerAccount1: createCustomerAccount(
                input: {
                  id: $accountID
                  companyName: "InitialAccount"
                  contact: {
                    contactName: "Initial"
                    emailAddress: "INI@test.com"
                    phoneNumber: "123456"
                  }
                }
              ) {
                id
              }
            }
          """,
        variables: {
          accountID: uuid.SHA1(#seed, hmac.Sign("SHA1", "Account", "1"))
        },
      },
      {
        query: """
            mutation ($leadID: ID) {
              createLead(
                input: {
                  id: $leadID
                  companyName: "AAccount"
                  leadSource: "Email"
                  stage: Open
                  dealAmount: "200"
                  contact: {
                    contactName: "AAAA"
                    emailAddress: "AAAA@test.com"
                    phoneNumber: "123456"
                  }
                }
              ) {
                id
              }
            }
          """
        variables: {
          leadID: uuid.SHA1(#seed, hmac.Sign("SHA1", "Lead", "1"))
        },
      },
      {
        query: """
          mutation ($accountID:ID!) {
            transaction1: createTransaction(
              input: {
                accountID: $accountID
                transactionDate: "2022-01-25"
                transactionAmt: 1000
                transactionType: "Monthly"
                transactionMethod: "Credit card"
              }
            ) {
              id
            }
            transaction2: createTransaction(
              input: {
                accountID: $accountID
                transactionDate: "2022-02-25"
                transactionAmt: 1500
                transactionType: "Monthly"
                transactionMethod: "Credit card"
              }
            ) {
              id
            }
            transaction3: createTransaction(
              input: {
                accountID: $accountID
                transactionDate: "2022-03-25"
                transactionAmt: 1500
                transactionType: "Monthly"
                transactionMethod: "Credit card"
              }
            ) {
              id
            }
            transaction4: createTransaction(
              input: {
                accountID: $accountID
                transactionDate: "2022-04-25"
                transactionAmt: 1500
                transactionType: "Monthly"
                transactionMethod: "Credit card"
              }
            ) {
              id
            }
          }
          """
        variables: {
          accountID: uuid.SHA1(#seed, hmac.Sign("SHA1", "Account", "1"))
        }
      },
    ]
  }
}
