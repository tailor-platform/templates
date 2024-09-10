package master

import (
	"tailor.build/template/seed/utils"
)

#Item: {
	item0: {
		id:				utils.uuid & {_, #type: "item", #value: "1"}
		name:           "Frame"
		description:    "frame"
		sku:            "FR-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item1: {
		id:				utils.uuid & {_, #type: "item", #value: "2"}
		name:           "Spokes"
		description:    "Spokes"
		sku:            "SK-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item2: {
		id:				utils.uuid & {_, #type: "item", #value: "3"}
		name:           "Handlebars"
		description:    "Handlebars"
		sku:            "HB-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item3: {
		id:				utils.uuid & {_, #type: "item", #value: "4"}
		name:           "Brakes"
		description:    "Brakes"
		sku:            "BR-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item4: {
		id:				utils.uuid & {_, #type: "item", #value: "5"}
		name:           "Wheels"
		description:    "Wheels"
		sku:            "WH-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item5: {
		id:				utils.uuid & {_, #type: "item", #value: "6"}
		name:           "Tube"
		description:    "Tube"
		sku:            "TB-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item6: {
		id:				utils.uuid & {_, #type: "item", #value: "7"}
		name:           "Pedals"
		description:    "Pedals"
		sku:            "Pedal-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item7: {
		id:				utils.uuid & {_, #type: "item", #value: "8"}
		name:           "Chain"
		description:    "chain"
		sku:            "chain-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "3"}
	}
	item8: {
		id:				utils.uuid & {_, #type: "item", #value: "9"}
		name:           "Bearing"
		description:    "Bearing"
		sku:            "Bearing-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item9: {
		id:				utils.uuid & {_, #type: "item", #value: "10"}
		name:           "Paint - Blue"
		description:    "paint blue"
		sku:            "PB-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "2"}
	}
	item10: {
		id:				utils.uuid & {_, #type: "item", #value: "11"}
		name:           "Paint - Red"
		description:    "paint blue"
		sku:            "PR-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "2"}
	}
	item11: {
		id:				utils.uuid & {_, #type: "item", #value: "12"}
		name:           "Round Frame"
		description:    "Round Frame"
		sku:            "RF-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item12: {
		id:				utils.uuid & {_, #type: "item", #value: "13"}
		name:           "Assemble time"
		description:    "Assemble time"
		sku:            "AT-001"
		isFinalProduct: false
		inventoryType:  "SERVICE"
		uomId:          utils.uuid & {_, #type: "uom", #value: "4"}
	}
	item13: {
		id:				utils.uuid & {_, #type: "item", #value: "14"}
		name:           "7-speed Advance Mountain bike"
		description:    "7-speed Advance Mountain bike"
		sku:            "7-speed-001"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
}

Item: {
	items: [
		for k, v in #Item {
			v
		},
	]
}
