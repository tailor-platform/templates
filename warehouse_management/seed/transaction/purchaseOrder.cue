package transaction

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	purchaseOrder1: {
		id: utils.Uuid & {_, #type: "PurchaseOrder", #value: "1"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "1"}
		supplierID: utils.Uuid & {_, #type: "Supplier", #value: "1"}
		purchaseOrderDate: "2023-04-01"
	}
	purchaseOrder2: {
		id: utils.Uuid & {_, #type: "PurchaseOrder", #value: "2"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "2"}
		supplierID: utils.Uuid & {_, #type: "Supplier", #value: "2"}
		purchaseOrderDate: "2023-04-15"
	}
	purchaseOrder3: {
		id: utils.Uuid & {_, #type: "PurchaseOrder", #value: "3"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "3"}
		supplierID: utils.Uuid & {_, #type: "Supplier", #value: "3"}
		purchaseOrderDate: "2023-05-01"
	}
	purchaseOrder4: {
		id: utils.Uuid & {_, #type: "PurchaseOrder", #value: "4"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "4"}
		supplierID: utils.Uuid & {_, #type: "Supplier", #value: "4"}
		purchaseOrderDate: "2023-05-15"
	}
	purchaseOrder5: {
		id: utils.Uuid & {_, #type: "PurchaseOrder", #value: "5"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "5"}
		supplierID: utils.Uuid & {_, #type: "Supplier", #value: "5"}
		purchaseOrderDate: "2023-06-01"
	}

}

PurchaseOrder: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
