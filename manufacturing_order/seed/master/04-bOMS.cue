package master

import (
	"tailor.build/template/seed/utils"
)

#Bom: {
	bom0: {
		id: utils.uuid & {_, #type: "bom", #value: "1"}
		name:           "7-speed Advance Mountain bike"
		description:    "The 7-Speed Advance Mountain Bike is designed for both novice and experienced riders who crave adventure on rugged trails and off-road terrains. Engineered with a lightweight yet durable aluminum frame, this bike ensures optimal performance and durability."
		outputQuantity: 1
		sku:            "7-speed-001"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:          utils.uuid & {_, #type: "item", #value: "14"}
	}
	bom1: {
		id: utils.uuid & {_, #type: "bom", #value: "2"}
		name:           "Wheel"
		description:    "Wheel"
		sku:            "wheel-001"
		outputQuantity: 1
		bomType:        "COMPONENT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "5"}
	}
	bom2: {
		id: utils.uuid & {_, #type: "bom", #value: "3"}
		name:           "Tube"
		description:    "Tube"
		sku:            "Tube-001"
		outputQuantity: 1
		bomType:        "COMPONENT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "6"}
	}
}

Bom: {
	items: [
		for k, v in #Bom {
			v
		},
	]
}
