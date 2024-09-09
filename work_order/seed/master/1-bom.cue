package master

import (
	"tailor.build/template/seed/utils"
)

#Bom: {
	bom0: {
		id: utils.uuid & {_, #type: "BOM", #value: "1"}
		name:           "Road Bike"
		description:    "Road bike"
		outputQuantity: 1
	}
	bom1: {
		id: utils.uuid & {_, #type: "BOM", #value: "2"}
		name:           "Mountain Bike"
		description:    "Mountain Bike"
		outputQuantity: 1
	}
	bom2: {
		id: utils.uuid & {_, #type: "BOM", #value: "3"}
		name:           "Hybrid Bike"
		description:    "Hybrid Bike"
		outputQuantity: 1
	}
}

Bom: {
	items: [
		for k, v in #Bom {
			v
		},
	]
}
