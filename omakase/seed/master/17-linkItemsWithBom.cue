package master

import (
	"tailor.build/template/seed/utils"
)

#Item: {
	item0: {
		id: utils.uuid & {_, #type: "item", #value: "1"}
		name:           "Brim Reinforcement"
		description:    "Component \"Brim Reinforcement\" for Ace Iconic Performance Hat."
		sku:            "ABS.#553175"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "1"}
	}

	item1: {
		id: utils.uuid & {_, #type: "item", #value: "2"}
		name:           "Crown Panel"
		description:    "Component \"Crown Panel\" for Ace Iconic Performance Hat."
		sku:            "AIR.#095921"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "2"}
	}

	item2: {
		id: utils.uuid & {_, #type: "item", #value: "3"}
		name:           "Sweatband"
		description:    "Component \"Sweatband\" for Ace Iconic Performance Hat."
		sku:            "SWB.#955373"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "3"}
	}

	item3: {
		id: utils.uuid & {_, #type: "item", #value: "4"}
		name:           "Size Adjuster"
		description:    "Component \"Size Adjuster\" for Ace Iconic Performance Hat."
		sku:            "ADJ.#657979"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "4"}
	}

	item4: {
		id: utils.uuid & {_, #type: "item", #value: "5"}
		name:           "Main Fabric Panel"
		description:    "Component \"Main Fabric Panel\" for Ace Iconic Performance Hat."
		sku:            "FAB.#852513"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "5"}
	}

	item5: {
		id: utils.uuid & {_, #type: "item", #value: "6"}
		name:           "Brim Insert"
		description:    "Component \"Brim Insert\" for Ace Iconic Performance Hat."
		sku:            "BRI.#379391"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "6"}
	}

	item6: {
		id: utils.uuid & {_, #type: "item", #value: "7"}
		name:           "Ventilation Eyelets"
		description:    "Component \"Ventilation Eyelets\" for Ace Iconic Performance Hat."
		sku:            "EYE.#681275"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "7"}
	}

	item7: {
		id: utils.uuid & {_, #type: "item", #value: "8"}
		name:           "Thread Package"
		description:    "Component \"Thread Package\" for Ace Iconic Performance Hat."
		sku:            "THR.#113742"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "8"}
	}

	item8: {
		id: utils.uuid & {_, #type: "item", #value: "9"}
		name:           "Care Labels"
		description:    "Component \"Care Labels\" for Ace Iconic Performance Hat."
		sku:            "CAU.#033854"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "9"}
	}

	item9: {
		id: utils.uuid & {_, #type: "item", #value: "10"}
		name:           "Closure System"
		description:    "Component \"Closure System\" for Ace Iconic Performance Hat."
		sku:            "CLS.#931707"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "10"}
	}

	item10: {
		id: utils.uuid & {_, #type: "item", #value: "11"}
		name:           "Inner Lining"
		description:    "Component \"Inner Lining\" for Ace Iconic Performance Hat."
		sku:            "LIN.#729357"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "11"}
	}

	item11: {
		id: utils.uuid & {_, #type: "item", #value: "12"}
		name:           "Brim Stitching Package"
		description:    "Component \"Brim Stitching Package\" for Ace Iconic Performance Hat."
		sku:            "BST.#945484"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "12"}
	}

	item12: {
		id: utils.uuid & {_, #type: "item", #value: "13"}
		name:           "Peak Insert"
		description:    "Component \"Peak Insert\" for Ace Iconic Performance Hat."
		sku:            "PEA.#635389"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "13"}
	}

	item13: {
		id: utils.uuid & {_, #type: "item", #value: "14"}
		name:           "Crown Support"
		description:    "Component \"Crown Support\" for Ace Iconic Performance Hat."
		sku:            "CRS.#503069"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "14"}
	}

	item14: {
		id: utils.uuid & {_, #type: "item", #value: "15"}
		name:           "Brim Edge Binding"
		description:    "Component \"Brim Edge Binding\" for Ace Iconic Performance Hat."
		sku:            "BEB.#947725"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "15"}
	}

	item15: {
		id: utils.uuid & {_, #type: "item", #value: "16"}
		name:           "Logo Patch"
		description:    "Component \"Logo Patch\" for Ace Iconic Performance Hat."
		sku:            "LOG.#291634"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "16"}
	}

	item16: {
		id: utils.uuid & {_, #type: "item", #value: "17"}
		name:           "Reinforcement Tape"
		description:    "Component \"Reinforcement Tape\" for Ace Iconic Performance Hat."
		sku:            "RFT.#232528"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "17"}
	}

	item17: {
		id: utils.uuid & {_, #type: "item", #value: "18"}
		name:           "Front Panel"
		description:    "Component \"Front Panel\" for Ace Iconic Performance Hat."
		sku:            "FRP.#646679"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "18"}
	}

	item18: {
		id: utils.uuid & {_, #type: "item", #value: "32"}
		name:           "Side Panels"
		description:    "Component \"Side Panels\" for Ace Iconic Performance Hat."
		sku:            "SDP.#417159"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "19"}
	}

	item19: {
		id: utils.uuid & {_, #type: "item", #value: "52"}
		name:           "Back Panel"
		description:    "Component \"Back Panel\" for Ace Iconic Performance Hat."
		sku:            "BKP.#382980"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "20"}
	}

	item20: {
		id: utils.uuid & {_, #type: "item", #value: "84"}
		name:           "Visor Component"
		description:    "Component \"Visor Component\" for Ace Iconic Performance Hat."
		sku:            "VIS.#611893"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "21"}
	}

	item21: {
		id: utils.uuid & {_, #type: "item", #value: "105"}
		name:           "Elastic Band"
		description:    "Component \"Elastic Band\" for Ace Iconic Performance Hat."
		sku:            "ELA.#060545"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "22"}
	}

	item22: {
		id: utils.uuid & {_, #type: "item", #value: "117"}
		name:           "Button Top"
		description:    "Component \"Button Top\" for Ace Iconic Performance Hat."
		sku:            "BTN.#072515"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "23"}
	}

	item23: {
		id: utils.uuid & {_, #type: "item", #value: "132"}
		name:           "Size Label"
		description:    "Component \"Size Label\" for Ace Iconic Performance Hat."
		sku:            "SZL.#682714"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "24"}
	}

	item24: {
		id: utils.uuid & {_, #type: "item", #value: "154"}
		name:           "Ace Iconic Performance Hat"
		description:    "Ace Iconic Performance Hat - Assembled parts"
		sku:            "ACE.HAT"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId:          utils.uuid & {_, #type: "bom", #value: "25"}
	}
}

Item: {
	items: [
		for k, v in #Item {
			v
		},
	]
	query: """
		mutation ($input: [ItemCreateInput]) {
			bulkUpsertItems(input: $input)
		}
	"""
}
