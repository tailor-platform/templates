package transaction

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	purchaseOrderLineItem1: {
		id: utils.Uuid & {_, #type: "PurchaseOrderLineItem", #value: "1"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "1"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		quantity: 200
	}
	purchaseOrderLineItem2: {
		id: utils.Uuid & {_, #type: "PurchaseOrderLineItem", #value: "2"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "2"}
		productID: utils.Uuid & {_, #type: "Product", #value: "2"}
		quantity: 150
	}
	purchaseOrderLineItem3: {
		id: utils.Uuid & {_, #type: "PurchaseOrderLineItem", #value: "3"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "3"}
		productID: utils.Uuid & {_, #type: "Product", #value: "3"}
		quantity: 100
	}
	purchaseOrderLineItem4: {
		id: utils.Uuid & {_, #type: "PurchaseOrderLineItem", #value: "4"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "4"}
		quantity: 400
	}
	purchaseOrderLineItem5: {
		id: utils.Uuid & {_, #type: "PurchaseOrderLineItem", #value: "5"}
		purchaseOrderID: utils.Uuid & {_, #type: "PurchaseOrder", #value: "5"}
		productID: utils.Uuid & {_, #type: "Product", #value: "5"}
		quantity: 240
	}

}

PurchaseOrderLineItem: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
