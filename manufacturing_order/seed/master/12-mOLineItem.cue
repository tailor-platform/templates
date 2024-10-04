package master

import (
	"tailor.build/template/seed/utils"
)

#MOLineItem: {
	mOLineItem0: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "1"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "6"}
		requiredQuantity: 1
		totalCost: 3
	}
	mOLineItem1: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "2"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "7"}
		requiredQuantity: 2
		totalCost: 16
	}
	mOLineItem2: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "3"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "8"}
		requiredQuantity: 2
		totalCost: 10
	}
	mOLineItem3: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "4"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "9"}
		requiredQuantity: 2
		totalCost: 4
	}
	mOLineItem4: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "5"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "10"}
		requiredQuantity: 2
		totalCost: 4
	}
	mOLineItem5: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "6"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "11"}
		requiredQuantity: 2
		totalCost: 2
	}
	mOLineItem6: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "7"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "12"}
		requiredQuantity: 4
		totalCost: 4
	}
}

MOLineItem: {
	items: [
		for k, v in #MOLineItem {
			v
		},
	]
}
