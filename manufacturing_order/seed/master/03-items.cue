package master

import (
	"tailor.build/template/seed/utils"
)

#Item: {
	item0: {
		id:             utils.uuid & {_, #type: "item", #value: "1"}
		name:           "Frame"
		description:    "frame"
		sku:            "FRM.#796611"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item1: {
		id:             utils.uuid & {_, #type: "item", #value: "2"}
		name:           "Spokes"
		description:    "Spokes"
		sku:            "SPK.#796612"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item2: {
		id:             utils.uuid & {_, #type: "item", #value: "3"}
		name:           "Handlebars"
		description:    "Handlebars"
		sku:            "HBAR.#796613"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item3: {
		id:             utils.uuid & {_, #type: "item", #value: "4"}
		name:           "Brakes"
		description:    "Brakes"
		sku:            "BRK.#796614"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item4: {
		id:             utils.uuid & {_, #type: "item", #value: "5"}
		name:           "Wheels"
		description:    "Wheels"
		sku:            "WHL.#796615"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item5: {
		id:             utils.uuid & {_, #type: "item", #value: "6"}
		name:           "Tube"
		description:    "Tube"
		sku:            "TBE.#796616"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item6: {
		id:             utils.uuid & {_, #type: "item", #value: "7"}
		name:           "Pedals"
		description:    "Pedals"
		sku:            "PDL.#796617"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item7: {
		id:             utils.uuid & {_, #type: "item", #value: "8"}
		name:           "Chain"
		description:    "chain"
		sku:            "CHN.#796618"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "3"}
	}
	item8: {
		id:             utils.uuid & {_, #type: "item", #value: "9"}
		name:           "Bearing"
		description:    "Bearing"
		sku:            "BRG.#796619"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item9: {
		id:             utils.uuid & {_, #type: "item", #value: "10"}
		name:           "Paint - Blue"
		description:    "paint blue"
		sku:            "PTBLU.#796620"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "2"}
	}
	item10: {
		id:             utils.uuid & {_, #type: "item", #value: "11"}
		name:           "Paint - Red"
		description:    "paint blue"
		sku:            "PTRED.#796621"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "2"}
	}
	item11: {
		id:             utils.uuid & {_, #type: "item", #value: "12"}
		name:           "Round Frame"
		description:    "Round Frame"
		sku:            "RFRM.#796622"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
	}
	item12: {
		id:             utils.uuid & {_, #type: "item", #value: "13"}
		name:           "Assemble time"
		description:    "Assemble time"
		sku:            "ASM.#796623"
		isFinalProduct: false
		inventoryType:  "SERVICE"
		uomId:          utils.uuid & {_, #type: "uom", #value: "4"}
	}
	item13: {
		id:             utils.uuid & {_, #type: "item", #value: "14"}
		name:           "7-speed Advance Mountain bike"
		description:    "7-speed Advance Mountain bike"
		sku:            "7SPMTB.#796624"
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
