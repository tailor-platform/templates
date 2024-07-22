package transaction

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	ShipOutLineItem1: {
		id: utils.Uuid & {_, #type: "ShipOutLineItem", #value: "1"}
		shipOutID: utils.Uuid & {_, #type: "ShipOut", #value: "1"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "1"}
		quantity: 20
	}
	ShipOutLineItem2: {
		id: utils.Uuid & {_, #type: "ShipOutLineItem", #value: "2"}
		shipOutID: utils.Uuid & {_, #type: "ShipOut", #value: "2"}
		productID: utils.Uuid & {_, #type: "Product", #value: "2"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "2"}
		quantity: 15
	}
	ShipOutLineItem3: {
		id: utils.Uuid & {_, #type: "ShipOutLineItem", #value: "3"}
		shipOutID: utils.Uuid & {_, #type: "ShipOut", #value: "3"}
		productID: utils.Uuid & {_, #type: "Product", #value: "3"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "3"}
		quantity: 10
	}
	ShipOutLineItem4: {
		id: utils.Uuid & {_, #type: "ShipOutLineItem", #value: "4"}
		shipOutID: utils.Uuid & {_, #type: "ShipOut", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "4"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "4"}
		quantity: 40
	}
	ShipOutLineItem5: {
		id: utils.Uuid & {_, #type: "ShipOutLineItem", #value: "5"}
		shipOutID: utils.Uuid & {_, #type: "ShipOut", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "5"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "5"}
		quantity: 24
	}
}

ShipOutLineItem: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
