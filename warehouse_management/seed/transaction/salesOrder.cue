package transaction

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	SalesOrder1: {
		id: utils.Uuid & {_, #type: "SalesOrder", #value: "1"}
		storeID: utils.Uuid & {_, #type: "Store", #value: "1"}
		salesOrderDate: "2023-07-01"
	}
	SalesOrder2: {
		id: utils.Uuid & {_, #type: "SalesOrder", #value: "2"}
		storeID: utils.Uuid & {_, #type: "Store", #value: "2"}
		salesOrderDate: "2023-07-15"
	}
	SalesOrder3: {
		id: utils.Uuid & {_, #type: "SalesOrder", #value: "3"}
		storeID: utils.Uuid & {_, #type: "Store", #value: "3"}
		salesOrderDate: "2023-08-01"
	}
	SalesOrder4: {
		id: utils.Uuid & {_, #type: "SalesOrder", #value: "4"}
		storeID: utils.Uuid & {_, #type: "Store", #value: "1"}
		salesOrderDate: "2023-08-15"
	}
}

SalesOrder: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
