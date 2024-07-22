package transaction

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	PutAwayLineItem1: {
		id: utils.Uuid & {_, #type: "PutAwayLineItem", #value: "1"}
		putAwayID: utils.Uuid & {_, #type: "PutAway", #value: "1"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "1"}
		quantity: 100
	}
	PutAwayLineItem2: {
		id: utils.Uuid & {_, #type: "PutAwayLineItem", #value: "2"}
		putAwayID: utils.Uuid & {_, #type: "PutAway", #value: "2"}
		productID: utils.Uuid & {_, #type: "Product", #value: "2"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "2"}
		quantity: 75
	}
	PutAwayLineItem3: {
		id: utils.Uuid & {_, #type: "PutAwayLineItem", #value: "3"}
		putAwayID: utils.Uuid & {_, #type: "PutAway", #value: "3"}
		productID: utils.Uuid & {_, #type: "Product", #value: "3"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "3"}
		quantity: 50
	}
	PutAwayLineItem4: {
		id: utils.Uuid & {_, #type: "PutAwayLineItem", #value: "4"}
		putAwayID: utils.Uuid & {_, #type: "PutAway", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "4"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "4"}
		quantity: 200
	}
	PutAwayLineItem5: {
		id: utils.Uuid & {_, #type: "PutAwayLineItem", #value: "5"}
		putAwayID: utils.Uuid & {_, #type: "PutAway", #value: "5"}
		productID: utils.Uuid & {_, #type: "Product", #value: "5"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "5"}
		quantity: 120
	}
}

PutAwayLineItem: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
