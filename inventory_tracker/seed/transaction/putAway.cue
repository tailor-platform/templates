package transaction

import (
	"tailor.build/template/seed/utils"
)

#PutAways: {
    PutAway1: {
        id: utils.uuid & {_, #type: "putAway", #value: "1"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "4"}
        quantity: 8,
        putAwayDate: "2023-11-02"
    },
    PutAway2: {
        id: utils.uuid & {_, #type: "putAway", #value: "2"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "3"}
        quantity: 19,
        putAwayDate: "2023-11-03"
    },
    PutAway3: {
        id: utils.uuid & {_, #type: "putAway", #value: "3"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "1"}
        quantity: 3,
        putAwayDate: "2023-11-05"
    },
    PutAway4: {
        id: utils.uuid & {_, #type: "putAway", #value: "4"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "1"}
        quantity: 7,
        putAwayDate: "2023-11-06"
    },
    PutAway5: {
        id: utils.uuid & {_, #type: "putAway", #value: "5"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "3"}
        quantity: 1,
        putAwayDate: "2023-11-06"
    },
    PutAway6: {
       id: utils.uuid & {_, #type: "putAway", #value: "6"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "4"}
        quantity: 1,
        putAwayDate: "2023-11-06"
    },
    PutAway7: {
        id: utils.uuid & {_, #type: "putAway", #value: "7"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "5"}
        quantity: 11,
        putAwayDate: "2023-11-06"
    },
    PutAway8: {
        id: utils.uuid & {_, #type: "putAway", #value: "8"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "5"}
        quantity: 7,
        putAwayDate: "2023-11-07"
    },
    PutAway9: {
       id: utils.uuid & {_, #type: "putAway", #value: "9"},
       purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "2"}
       quantity: 7,
       putAwayDate: "2023-11-07"
    },
    PutAway10: {
        id: utils.uuid & {_, #type: "putAway", #value: "10"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "8"}
        quantity: 10,
        putAwayDate: "2023-11-07"
    },
    PutAway11: {
        id: utils.uuid & {_, #type: "putAway", #value: "11"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "10"}
        quantity: 2,
        putAwayDate: "2023-11-07"
    },
    PutAway12: {
        id: utils.uuid & {_, #type: "putAway", #value: "12"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "6"}
        quantity: 20,
        putAwayDate: "2023-11-08"
    },
    PutAway13: {
        id: utils.uuid & {_, #type: "putAway", #value: "13"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "6"}
        quantity: 50,
        putAwayDate: "2023-11-09"
    },
    PutAway14: {
        id: utils.uuid & {_, #type: "putAway", #value: "14"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "11"}
        quantity: 7,
        putAwayDate: "2023-11-09"
    },
    PutAway15: {
        id: utils.uuid & {_, #type: "putAway", #value: "15"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "2"}
        quantity: 3,
        putAwayDate: "2023-11-10"
    },
    PutAway16: {
        id: utils.uuid & {_, #type: "putAway", #value: "16"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "8"}
        quantity: 2,
        putAwayDate: "2023-11-11"
    },
    PutAway17: {
        id: utils.uuid & {_, #type: "putAway", #value: "17"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "7"}
        quantity: 3,
        putAwayDate: "2023-11-11"
    },
    PutAway18: {
        id: utils.uuid & {_, #type: "putAway", #value: "18"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "9"}
        quantity: 40,
        putAwayDate: "2023-11-12"
    },
    PutAway19: {
        id: utils.uuid & {_, #type: "putAway", #value: "19"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "9"}
        quantity: 10,
        putAwayDate: "2023-11-14"
    },
    PutAway20: {
        id: utils.uuid & {_, #type: "putAway", #value: "20"},
        purchaseOrderID: utils.uuid & {_, #type: "purchaseOrder", #value: "11"}
        quantity: 2,
        putAwayDate: "2023-11-17"
    }
}

PutAway: {
   items: [
		for k, v in #PutAways {
			v
		},
	],
}
