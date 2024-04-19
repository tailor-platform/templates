package transactionWithEvent

import (
	"tailor.build/template/seed/utils"
)

#PutAways: {
    PutAway101: {
        id: utils.uuid & {_, #type: "putAway", #value: "101"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "101"},
        lotID: utils.uuid & {_, #type: "lot", #value: "101"},
        quantity: 8,
        putAwayDate: "2023-11-02"
    },
    PutAway102: {
        id: utils.uuid & {_, #type: "putAway", #value: "102"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "102"},
        lotID: utils.uuid & {_, #type: "lot", #value: "102"},
        quantity: 11,
        putAwayDate: "2023-11-03"
    }
}

PutAwayWithEvent: {
   items: [
		for k, v in #PutAways {
			v
		},
	],
    query: """
    mutation ($input: createPutAwayWithEventInput!) {
        putAway101: createPutAwayWithEvent(input: $input)
    }"""
}
