package master

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	Bin1: {
		id: utils.Uuid & {_, #type: "Bin", #value: "1"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "1"}
		barcode:   99999
		shelf:     "Staging"
		isDefault: true
	}
	Bin2: {
		id: utils.Uuid & {_, #type: "Bin", #value: "2"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "1"}
		barcode:   23456
		shelf:     "A-1"
		isDefault: false
	}
	Bin3: {
		id: utils.Uuid & {_, #type: "Bin", #value: "3"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "1"}
		barcode:   34567
		shelf:     "C-3"
		isDefault: false
	}
	Bin4: {
		id: utils.Uuid & {_, #type: "Bin", #value: "4"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "2"}
		barcode:   99999
		shelf:     "Staging"
		isDefault: true
	}
	Bin5: {
		id: utils.Uuid & {_, #type: "Bin", #value: "5"}
		warehouseID: utils.Uuid & {_, #type: "Warehouse", #value: "2"}
		barcode:   56789
		shelf:     "A-2"
		isDefault: false
	}
}

Bin: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
