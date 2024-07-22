package master

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	BinStock1: {
		id: utils.Uuid & {_, #type: "BinStock", #value: "1"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "1"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		quantity: 100
	}
	BinStock2: {
		id: utils.Uuid & {_, #type: "BinStock", #value: "2"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "1"}
		productID: utils.Uuid & {_, #type: "Product", #value: "2"}
		quantity: 75
	}
	BinStock3: {
		id: utils.Uuid & {_, #type: "BinStock", #value: "3"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "2"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		quantity: 50
	}
	BinStock4: {
		id: utils.Uuid & {_, #type: "BinStock", #value: "4"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "3"}
		productID: utils.Uuid & {_, #type: "Product", #value: "1"}
		quantity: 200
	}
	BinStock5: {
		id: utils.Uuid & {_, #type: "BinStock", #value: "5"}
		binID: utils.Uuid & {_, #type: "Bin", #value: "4"}
		productID: utils.Uuid & {_, #type: "Product", #value: "3"}
		quantity: 120
	}
}

BinStock: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
