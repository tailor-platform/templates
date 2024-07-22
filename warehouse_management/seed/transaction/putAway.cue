package transaction

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	PutAway1: {
		id: utils.Uuid & {_, #type: "PutAway", #value: "1"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "1"}
		putAwayDate: "2023-04-05"
	}
	PutAway2: {
		id: utils.Uuid & {_, #type: "PutAway", #value: "2"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "2"}
		putAwayDate: "2023-04-20"
	}
	PutAway3: {
		id: utils.Uuid & {_, #type: "PutAway", #value: "3"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "3"}
		putAwayDate: "2023-05-05"
	}
	PutAway4: {
		id: utils.Uuid & {_, #type: "PutAway", #value: "4"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "4"}
		putAwayDate: "2023-05-20"
	}
	PutAway5: {
		id: utils.Uuid & {_, #type: "PutAway", #value: "5"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "5"}
		putAwayDate: "2023-06-05"
	}
}

PutAway: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
