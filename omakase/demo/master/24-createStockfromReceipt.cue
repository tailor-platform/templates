package master

import (
	"tailor.build/template/seed/utils"
)

#PO: {
	poLineItem0: {
		receiptLineItemIDs: [
			utils.uuid & {_, #type: "ReceiptLineItem", #value: "1"},
			utils.uuid & {_, #type: "ReceiptLineItem", #value: "2"}
		]
	}
}

PO: {
	items: [
		for k, v in #PO {
			v
		},
	]
	query: """
mutation MyMutation($input: createStockEventsFromReceiptLineItemsInput!) {
  createStockEventsFromReceiptLineItems(input: $input) {
    stockEventIDs
  }
}"""
}
