package master

import (
	"tailor.build/template/seed/utils"
)

#BomLineItem: {
	bomLineitem0: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"} // wheel
		itemId: utils.uuid & {_, #type: "item", #value: "6"} // tube
		inputQuantity: 1
		unitCost: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
	}
	bomLineitem1: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "2"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"} // wheel
		itemId: utils.uuid & {_, #type: "item", #value: "9"} // bearing
		inputQuantity: 10
		unitCost: 10
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
	}
	bomLineitem2: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "3"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"} // wheel
		itemId: utils.uuid & {_, #type: "item", #value: "2"} // spokes
		inputQuantity: 10
		unitCost: 20
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
	}
	bomLineitem3: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "4"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"} // wheel
		itemId: utils.uuid & {_, #type: "item", #value: "12"} // Round frame
		inputQuantity: 1
		unitCost: 5
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
	}
	bomLineitem4: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "5"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"} // wheel
		itemId: utils.uuid & {_, #type: "item", #value: "13"} // Assemble time
		inputQuantity: 1
		unitCost: 6
		uomId: utils.uuid & {_, #type: "uom", #value: "4"}
	}
	bomLineitem5: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "6"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"} // 7-speed Advance Mountain bike
		itemId: utils.uuid & {_, #type: "item", #value: "3"} // handle bars
		inputQuantity: 1
		unitCost: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
	}
	bomLineitem6: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "7"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"} // 7-speed Advance Mountain bike
		itemId: utils.uuid & {_, #type: "item", #value: "4"} // brakes
		inputQuantity: 2
		unitCost: 8
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
	}
	bomLineitem7: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "8"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"} // 7-speed Advance Mountain bike
		itemId: utils.uuid & {_, #type: "item", #value: "5"} // Wheels
		unitCost: 5
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
	}
	bomLineitem8: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "9"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"} // 7-speed Advance Mountain bike
		itemId: utils.uuid & {_, #type: "item", #value: "7"} // Pedals
		unitCost: 2
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
	}
	bomLineitem9: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "10"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"} // 7-speed Advance Mountain bike
		itemId: utils.uuid & {_, #type: "item", #value: "8"} // chain
		unitCost: 2
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "3"}
	}
	bomLineitem10: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "11"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"} // 7-speed Advance Mountain bike
		itemId: utils.uuid & {_, #type: "item", #value: "10"} // paint blue
		unitCost: 1
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "2"}
	}
	bomLineitem11: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "12"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"} // 7-speed Advance Mountain bike
		itemId: utils.uuid & {_, #type: "item", #value: "13"} // Assemble time
		unitCost: 1
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "4"}
	}
}

BomLineItem: {
	items: [
		for k, v in #BomLineItem {
			v
		},
	]
}
