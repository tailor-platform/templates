package master

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	Product1: {
		id: utils.Uuid & {_, #type: "Product", #value: "1"}
		code:             "049000040692"
		brand:            "Nike"
		style:            "Nike Pegasus 40"
		category:         "Running Shoes"
		cost:             57.99
		msrp:             115.99
		uom:              "pair"
		sellingStartDate: "2023-01-01"
	}
	Product2: {
		id: utils.Uuid & {_, #type: "Product", #value: "2"}
		code:             "049000040681"
		brand:            "Nike"
		style:            "Nike InfinityRN 4"
		category:         "Running Shoes"
		cost:             44.99
		msrp:             89.99
		uom:              "pair"
		sellingStartDate: "2023-01-15"
	}
	Product3: {
		id: utils.Uuid & {_, #type: "Product", #value: "3"}
		code:             "049000040673"
		brand:            "New Balance"
		style:            "Fresh Foam X 1080v13"
		category:         "Running Shoes"
		cost:             72.75
		msrp:             145.5
		uom:              "pair"
		sellingStartDate: "2023-02-01"
	}
	Product4: {
		id: utils.Uuid & {_, #type: "Product", #value: "4"}
		code:             "049000040664"
		brand:            "New Balance"
		style:            "NB1300 v3"
		category:         "Lifestyle Sneaker"
		cost:             149.99
		msrp:             299.99
		uom:              "pair"
		sellingStartDate: "2023-02-15"
	}
	Product5: {
		id: utils.Uuid & {_, #type: "Product", #value: "5"}
		code:             "049000040655"
		brand:            "PRADA"
		style:            "Brushed leather lace-up shoes"
		category:         "Men's Formal"
		cost:             565.49
		msrp:             1130.99
		uom:              "pair"
		sellingStartDate: "2023-03-01"
	}
}

Product: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
