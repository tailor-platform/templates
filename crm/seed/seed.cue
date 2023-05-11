package graphqlseed

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindGraphqlSeed
	spec:    manifest.#SpecGraphqlSeed & {
		mutations: accountMutationList + leadMutationList + transactionMutationList
	}
}

let accountMutationList = [
	for k, v in accounts {
		{
			query: """
			mutation (
			  $accountID: ID
			  $companyName: String
			  $contactName: String
			  $emailAddress: String
			  $phoneNumber: String
			  ) {
			  CustomerAccount1: createCustomerAccount(
			    input: {
			      id: $accountID
			      companyName: $companyName
			      contact: {
			        contactName: $contactName
			        emailAddress: $emailAddress
			        phoneNumber: $phoneNumber
			      }
			    }
			  ) {
			    id
			  }
			}
			"""
			variables: {
				accountID:    v.accountID
				companyName:  v.companyName
				contactName:  v.contactName
				emailAddress: v.emailAddress
				phoneNumber:  v.phoneNumber
			}
		}
	},
]

accounts: {
	account1: {
		accountID: {{ generateWorkspaceUUID "Account1" | quote }}
		companyName:  "Account1"
		contactName:  "JOHN"
		emailAddress: "john@1.com"
		phoneNumber:  "123456"
	}
	account2: {
		accountID: {{ generateWorkspaceUUID "Account2" | quote }}
		companyName:  "Account2"
		contactName:  "JACK"
		emailAddress: "jack@2.com"
		phoneNumber:  "123456"
	}

}

let leadMutationList = [
	for k, v in leads {
		{
			query: """
				mutation (
				  $leadID: ID
				  $companyName: String
				  $leadSource: String
				  $stage: LeadStage
				  $dealAmount: String
				  $contactName: String
				  $emailAddress: String
				  $phoneNumber: String
				) {
				  createLead(
				    input: {
				      id: $leadID
				      companyName: $companyName
				      leadSource: $leadSource
				      stage: $stage
				      dealAmount: $dealAmount
				      contact: {
				        contactName: $contactName
				        emailAddress: $emailAddress
				        phoneNumber: $phoneNumber
				      }
				    }
				  ) {
				    id
				  }
				}      
				"""
			variables: {
				leadID:       v.leadID
				companyName:  v.companyName
				leadSource:   v.leadSource
				stage:        v.stage
				dealAmount:   v.dealAmount
				contactName:  v.contactName
				emailAddress: v.emailAddress
				phoneNumber:  v.phoneNumber
			}
		}
	},
]

leads: {
	lead1: {
		leadID: {{ generateWorkspaceUUID "Lead1" | quote }}
		companyName:  "AAccount"
		leadSource:   "Email"
		stage:        "Open"
		dealAmount:   "200"
		contactName:  "AAAA"
		emailAddress: "AAAA@test.com"
		phoneNumber:  "123456"
	}
	lead2: {
		leadID: {{ generateWorkspaceUUID "Lead2" | quote }}
		companyName:  "BAccount"
		leadSource:   "Email"
		stage:        "WIP"
		dealAmount:   "200"
		contactName:  "BBBB"
		emailAddress: "BBBB@test.com"
		phoneNumber:  "123456"
	}
	lead3: {
		leadID: {{ generateWorkspaceUUID "Lead3" | quote }}
		companyName:  "CAccount"
		leadSource:   "Email"
		stage:        "Won"
		dealAmount:   "200"
		contactName:  "CCCC"
		emailAddress: "CCCC@test.com"
		phoneNumber:  "123456"
	}
	lead4: {
		leadID: {{ generateWorkspaceUUID "Lead4" | quote }}
		companyName:  "DAccount"
		leadSource:   "Email"
		stage:        "Lost"
		dealAmount:   "200"
		contactName:  "DDDD"
		emailAddress: "DDDD@test.com"
		phoneNumber:  "123456"
	}
}

let transactionMutationList = [
	for k, v in transactions {
		{
			query: """
				mutation (
				  $accountID: ID!
				  $transactionDate: Date!
				  $transactionAmt: Int!
				  $transactionType: String
				  $transactionMethod: String
				) {
				  createTransaction(
				    input: {
				      accountID: $accountID
				      transactionDate: $transactionDate
				      transactionAmt: $transactionAmt
				      transactionType: $transactionType
				      transactionMethod: $transactionMethod
				    }
				  ) {
				    id
				  }
				}      
				"""
			variables: {
				accountID:         v.accountID
				transactionDate:   v.transactionDate
				transactionAmt:    v.transactionAmt
				transactionType:   v.transactionType
				transactionMethod: v.transactionMethod
			}
		}
	},
]

transactions: {
	transaction1: {
		accountID: {{ generateWorkspaceUUID "Account1" | quote }}
		transactionDate:   "2022-01-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction2: {
		accountID: {{ generateWorkspaceUUID "Account1" | quote }}
		transactionDate:   "2022-02-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction3: {
		accountID: {{ generateWorkspaceUUID "Account1" | quote }}
		transactionDate:   "2022-03-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction4: {
		accountID: {{ generateWorkspaceUUID "Account1" | quote }}
		transactionDate:   "2022-04-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
}
