package transactionWithEvent

import (
	"tailor.build/template/seed/utils"
)

#PurchaseOrders: {
    PurchaseOrder101: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "101"},
        productID: utils.uuid & {_, #type: "product", #value: "1"},
        locationID: utils.uuid & {_, #type: "location", #value: "1"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "1"},
        quantity: 10,
        purchaseOrderDate: "2023-11-02"
    },
    PurchaseOrder102: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "102"},
        productID: utils.uuid & {_, #type: "product", #value: "2"},
        locationID: utils.uuid & {_, #type: "location", #value: "2"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "2"},
        quantity: 10,
        purchaseOrderDate: "2023-11-02"
    }
}

PurchaseOrder: {
   items: [
		for k, v in #PurchaseOrders {
			v
		},
	],
}

