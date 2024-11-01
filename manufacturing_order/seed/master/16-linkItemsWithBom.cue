package master

import (
	"tailor.build/template/seed/utils"
)

#Item: {
	item0: {
		id: utils.uuid & {_, #type: "item", #value: "1"}
		name:           "Abs Modulator"
		description:    "Component \"Abs Modulator\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "ABS.#553175"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
	}

	item1: {
		id: utils.uuid & {_, #type: "item", #value: "2"}
		name:           "Air Cleaner"
		description:    "Component \"Air Cleaner\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "AIR.#095921"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
	}

	item2: {
		id: utils.uuid & {_, #type: "item", #value: "3"}
		name:           "Alternator"
		description:    "Component \"Alternator\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "ALT.#955373"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "3"}
	}

	item3: {
		id: utils.uuid & {_, #type: "item", #value: "4"}
		name:           "Battery"
		description:    "Component \"Battery\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "BAT.#657979"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "4"}
	}

	item4: {
		id: utils.uuid & {_, #type: "item", #value: "5"}
		name:           "Body / Cover"
		description:    "Component \"Body / Cover\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "BOD.#852513"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "5"}
	}

	item5: {
		id: utils.uuid & {_, #type: "item", #value: "6"}
		name:           "Cam Chain Tensioner"
		description:    "Component \"Cam Chain Tensioner\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CAM.#379391"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "6"}
	}

	item6: {
		id: utils.uuid & {_, #type: "item", #value: "7"}
		name:           "Camshaft-Valve"
		description:    "Component \"Camshaft-Valve\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CAMVAL.#681275"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "7"}
	}

	item7: {
		id: utils.uuid & {_, #type: "item", #value: "8"}
		name:           "Canister"
		description:    "Component \"Canister\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CAN.#113742"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "8"}
	}

	item8: {
		id: utils.uuid & {_, #type: "item", #value: "9"}
		name:           "Caution Labels"
		description:    "Component \"Caution Labels\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CAU.#033854"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "9"}
	}

	item9: {
		id: utils.uuid & {_, #type: "item", #value: "10"}
		name:           "Clutch"
		description:    "Component \"Clutch\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CLU.#931707"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "10"}
	}

	item10: {
		id: utils.uuid & {_, #type: "item", #value: "11"}
		name:           "Crankcase"
		description:    "Component \"Crankcase\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CRA.#729357"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "11"}
	}

	item11: {
		id: utils.uuid & {_, #type: "item", #value: "12"}
		name:           "Crankshaft Piston"
		description:    "Component \"Crankshaft Piston\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CRA.#945484"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "12"}
	}

	item12: {
		id: utils.uuid & {_, #type: "item", #value: "13"}
		name:           "Cylinder"
		description:    "Component \"Cylinder\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CYL.#635389"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "13"}
	}

	item13: {
		id: utils.uuid & {_, #type: "item", #value: "14"}
		name:           "Cylinder Head"
		description:    "Component \"Cylinder Head\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "CYL.#503069"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "14"}
	}

	item14: {
		id: utils.uuid & {_, #type: "item", #value: "15"}
		name:           "Frame"
		description:    "Component \"Frame\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "FRA.#947725"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "15"}
	}

	item15: {
		id: utils.uuid & {_, #type: "item", #value: "16"}
		name:           "Front Brake Master Cylinder"
		description:    "Component \"Front Brake Master Cylinder\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "FRO.#291634"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "16"}
	}

	item16: {
		id: utils.uuid & {_, #type: "item", #value: "17"}
		name:           "Front Brake-Caliper"
		description:    "Component \"Front Brake-Caliper\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "FROCAL.#232528"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "17"}
	}

	item17: {
		id: utils.uuid & {_, #type: "item", #value: "18"}
		name:           "Front Cover / Leg Shield"
		description:    "Component \"Front Cover / Leg Shield\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "FRO.#646679"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "18"}
	}

	item18: {
		id: utils.uuid & {_, #type: "item", #value: "32"}
		name:           "Front Fender"
		description:    "Component \"Front Fender\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "FRO.#417159"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
	}

	item19: {
		id: utils.uuid & {_, #type: "item", #value: "52"}
		name:           "Rear Fender"
		description:    "Component \"Rear Fender\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "REA.#382980"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
	}

	item20: {
		id: utils.uuid & {_, #type: "item", #value: "84"}
		name:           "Front Fork"
		description:    "Component \"Front Fork\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "FRO.#611893"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
	}

	item21: {
		id: utils.uuid & {_, #type: "item", #value: "105"}
		name:           "Rear Shock Absorber"
		description:    "Component \"Rear Shock Absorber\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "REA.#060545"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "22"}
	}

	item22: {
		id: utils.uuid & {_, #type: "item", #value: "117"}
		name:           "Front Wheel"
		description:    "Component \"Front Wheel\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "FRO.#072515"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
	}

	item23: {
		id: utils.uuid & {_, #type: "item", #value: "132"}
		name:           "Rear Wheel"
		description:    "Component \"Rear Wheel\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		sku:            "REA.#682714"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
	}

	item24: {
		id: utils.uuid & {_, #type: "item", #value: "154"}
		name:           "Honda Motorcycle C125A 2AC"
		description:    "Honda Motorcycle C125A 2AC - Assembled parts"
		sku:            "HND.C125A2AC"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
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
					}"""
}
