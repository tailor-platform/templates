package master

import (
	"tailor.build/template/seed/utils"
)

#Transactions: {
	transaction1: {
		id: utils.uuid & {_, #type: "transaction", #value: "1"}
		accountID: utils.uuid & {_, #type: "customerAccount", #value: "1"}
		transactionDate:   "2022-01-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction2: {
		id: utils.uuid & {_, #type: "transaction", #value: "2"}
		accountID: utils.uuid & {_, #type: "customerAccount", #value: "1"}
		transactionDate:   "2022-02-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction3: {
		id: utils.uuid & {_, #type: "transaction", #value: "3"}
		accountID: utils.uuid & {_, #type: "customerAccount", #value: "1"}
		transactionDate:   "2022-03-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
	transaction4: {
		id: utils.uuid & {_, #type: "transaction", #value: "4"}
		accountID: utils.uuid & {_, #type: "customerAccount", #value: "1"}
		transactionDate:   "2022-04-25"
		transactionAmt:    1500
		transactionType:   "Monthly"
		transactionMethod: "Credit card"
	}
}

Transaction: {
	items: [
		for k, v in #Transactions {
			v
		},
	]
}