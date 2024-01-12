package graphqlseed

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
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
		accountID: "a28123c0-c729-4c3d-9385-5a4706869d9f"
		companyName:  "Globex Corporation"
		contactName:  "Hank Scorpio"
		emailAddress: "hank.scorpio@globex.com"
		phoneNumber:  "(212) 555-1234"
	}
	account2: {
		accountID: "c1dcfe3d-99b0-4f13-a50c-95103792df5b"
		companyName:  "Initech"
		contactName:  "Bill Lumbergh"
		emailAddress: "bill.lumbergh@initech.com"
		phoneNumber:  "(310) 555-5678"
	}
	account3: {
		accountID: "921f9e90-cf2f-47c9-b53f-ada75cfeeb6b"
		companyName:  "Vandelay Industries"
		contactName:  "Art Vandelay"
		emailAddress: "art.vandelay@vandelay.com"
		phoneNumber:  "(312) 555-9012"
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
		leadID: "241f3af8-b528-4c34-90d0-783075076cae"
		companyName:  "Duff Beer"
		leadSource:   "Trade Show"
		stage:        "Open"
		dealAmount:   "4500"
		contactName:  "Duffman"
		emailAddress: "duffman@duffbeer.com"
		phoneNumber:  "(702) 555-3456"
	}
	lead2: {
		leadID: "ba3139f7-43b6-4cc5-bdf3-349ac2244b5b"
		companyName:  "Acme Corp"
		leadSource:   "Referral"
		stage:        "WIP"
		dealAmount:   "12000"
		contactName:  "Wile E. Coyote"
		emailAddress: "w.coyote@acme.com"
		phoneNumber:  "(305) 555-7890"
	}
	lead3: {
		leadID: "c6ce35df-b2bf-4e3a-a49a-02016db17712"
		companyName:  "Bluth Company"
		leadSource:   "Website"
		stage:        "Won"
		dealAmount:   "25000"
		contactName:  "Michael Bluth"
		emailAddress: "michael@bluth.com"
		phoneNumber:  "(512) 555-1234"
	}
	lead4: {
		leadID: "d0f24ab3-da70-4783-9f46-1825370a90df"
		companyName:  "Wonka Industries"
		leadSource:   "Email"
		stage:        "Lost"
		dealAmount:   "6000"
		contactName:  "Willy Wonka"
		emailAddress: "w.wonka@wonka.com"
		phoneNumber:  "(415) 555-5678"
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
		accountID: "bce38469-3d23-4411-ac09-02e417840f92"
		transactionDate:   "2022-01-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction2: {
		accountID: "34d427d7-016d-4fc4-bf82-4caf35583f08"
		transactionDate:   "2022-02-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction3: {
		accountID: "eb4dab8e-d577-4389-aa9f-66c0325063e0"
		transactionDate:   "2022-03-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction4: {
		accountID: "7ef0f1c2-3b69-49dc-93dd-c177a3eff600"
		transactionDate:   "2022-04-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
}
