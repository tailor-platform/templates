package transaction

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	SalesOrderLineItem1: {
		id: utils.Uuid & {_, #type: "SalesOrderLineItem", #value: "1"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "1"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		quantity: 20
	}
	SalesOrderLineItem2: {
		id: utils.Uuid & {_, #type: "SalesOrderLineItem", #value: "2"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "2"}
		productID: utils.Uuid & {_, #type: "Product", #value: "2"}
		quantity: 15
	}
	SalesOrderLineItem3: {
		id: utils.Uuid & {_, #type: "SalesOrderLineItem", #value: "3"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "3"}
		productID: utils.Uuid & {_, #type: "Product", #value: "3"}
		quantity: 10
	}
	SalesOrderLineItem4: {
		id: utils.Uuid & {_, #type: "SalesOrderLineItem", #value: "4"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "4"}
		quantity: 40
	}
	SalesOrderLineItem5: {
		id: utils.Uuid & {_, #type: "SalesOrderLineItem", #value: "5"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "5"}
		quantity: 24
	}
	SalesOrderLineItem6: {
		id: utils.Uuid & {_, #type: "SalesOrderLineItem", #value: "6"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		quantity: 15
	}
	SalesOrderLineItem7: {
		id: utils.Uuid & {_, #type: "SalesOrderLineItem", #value: "7"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		quantity: 10
	}
}

SalesOrderLineItem: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
