package transaction

import (
	"tailor.build/template/seed/utils"
)

#PurchaseOrders: {
    PurchaseOrder1: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "1"},
        productID: utils.uuid & {_, #type: "product", #value: "1"}
        locationID: utils.uuid & {_, #type: "location", #value: "1"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "1"}
        quantity: 10,
        purchaseOrderDate: "2023-11-01"
    },
    PurchaseOrder2: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "2"},
        productID: utils.uuid & {_, #type: "product", #value: "2"}
        locationID: utils.uuid & {_, #type: "location", #value: "2"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "2"}
        quantity: 10,
        purchaseOrderDate: "2023-11-01"
    },
    PurchaseOrder3: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "3"},
        productID: utils.uuid & {_, #type: "product", #value: "3"}
        locationID: utils.uuid & {_, #type: "location", #value: "3"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "3"}
        quantity: 20,
        purchaseOrderDate: "2023-11-01"
    },
    PurchaseOrder4: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "4"},
        productID: utils.uuid & {_, #type: "product", #value: "4"}
        locationID: utils.uuid & {_, #type: "location", #value: "4"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "4"}
        quantity: 9,
        purchaseOrderDate: "2023-11-01"
    },
    PurchaseOrder5: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "5"},
        productID: utils.uuid & {_, #type: "product", #value: "5"}
        locationID: utils.uuid & {_, #type: "location", #value: "5"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "5"}
        quantity: 18,
        purchaseOrderDate: "2023-11-02"
    },
    PurchaseOrder6: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "6"},
        productID: utils.uuid & {_, #type: "product", #value: "6"}
        locationID: utils.uuid & {_, #type: "location", #value: "6"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "6"}
        quantity: 70,
        purchaseOrderDate: "2023-11-03"
    },
    PurchaseOrder7: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "7"},
        productID: utils.uuid & {_, #type: "product", #value: "7"}
        locationID: utils.uuid & {_, #type: "location", #value: "7"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "7"}
        quantity: 3,
        purchaseOrderDate: "2023-11-04"
    },
    PurchaseOrder8: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "8"},
        productID: utils.uuid & {_, #type: "product", #value: "8"}
        locationID: utils.uuid & {_, #type: "location", #value: "8"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "8"}
        quantity: 12,
        purchaseOrderDate: "2023-11-05"
    },
    PurchaseOrder9: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "9"},
        productID: utils.uuid & {_, #type: "product", #value: "9"}
        locationID: utils.uuid & {_, #type: "location", #value: "9"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "9"}
        quantity: 50,
        purchaseOrderDate: "2023-11-06"
    },
    PurchaseOrder10: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "10"},
        productID: utils.uuid & {_, #type: "product", #value: "10"}
        locationID: utils.uuid & {_, #type: "location", #value: "10"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "10"}
        quantity: 2,
        purchaseOrderDate: "2023-11-07"
    },
    PurchaseOrder11: {
        id: utils.uuid & {_, #type: "purchaseOrder", #value: "11"},
        productID: utils.uuid & {_, #type: "product", #value: "11"}
        locationID: utils.uuid & {_, #type: "location", #value: "11"},
        supplierID: utils.uuid & {_, #type: "supplier", #value: "11"}
        quantity: 9,
        purchaseOrderDate: "2023-11-08"
        
    }
}

PurchaseOrder: {
   items: [
		for k, v in #PurchaseOrders {
			v
		},
	],
}
