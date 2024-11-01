package master

import (
	"tailor.build/template/seed/utils"
)

#Bom: {
	bom0: {
		id: utils.uuid & {_, #type: "bom", #value: "1"}
		name:           "Abs Modulator"
		description:    "Component \"abs modulator\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "ABS.#553175"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "1"}
	}

	bom1: {
		id: utils.uuid & {_, #type: "bom", #value: "2"}
		name:           "Air Cleaner"
		description:    "Component \"air cleaner\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "AIR.#095921"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "2"}
	}

	bom2: {
		id: utils.uuid & {_, #type: "bom", #value: "3"}
		name:           "Alternator"
		description:    "Component \"alternator\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "ALT.#955373"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "3"}
	}

	bom3: {
		id: utils.uuid & {_, #type: "bom", #value: "4"}
		name:           "Battery"
		description:    "Component \"battery\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "BAT.#657979"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "4"}
	}

	bom4: {
		id: utils.uuid & {_, #type: "bom", #value: "5"}
		name:           "Body / Cover"
		description:    "Component \"body / cover\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "BOD.#852513"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "5"}
	}

	bom5: {
		id: utils.uuid & {_, #type: "bom", #value: "6"}
		name:           "Cam Chain Tensioner"
		description:    "Component \"cam chain tensioner\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CAM.#379391"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "6"}
	}

	bom6: {
		id: utils.uuid & {_, #type: "bom", #value: "7"}
		name:           "Camshaft-Valve"
		description:    "Component \"camshaft-valve\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CAMVAL.#681275"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "7"}
	}

	bom7: {
		id: utils.uuid & {_, #type: "bom", #value: "8"}
		name:           "Canister"
		description:    "Component \"canister\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CAN.#113742"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "8"}
	}

	bom8: {
		id: utils.uuid & {_, #type: "bom", #value: "9"}
		name:           "Caution Labels"
		description:    "Component \"caution labels\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CAU.#033854"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "9"}
	}

	bom9: {
		id: utils.uuid & {_, #type: "bom", #value: "10"}
		name:           "Clutch"
		description:    "Component \"clutch\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CLU.#931707"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "10"}
	}

	bom10: {
		id: utils.uuid & {_, #type: "bom", #value: "11"}
		name:           "Crankcase"
		description:    "Component \"crankcase\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CRA.#729357"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "11"}
	}

	bom11: {
		id: utils.uuid & {_, #type: "bom", #value: "12"}
		name:           "Crankshaft Piston"
		description:    "Component \"crankshaft piston\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CRA.#945484"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "12"}
	}

	bom12: {
		id: utils.uuid & {_, #type: "bom", #value: "13"}
		name:           "Cylinder"
		description:    "Component \"cylinder\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CYL.#635389"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "13"}
	}

	bom13: {
		id: utils.uuid & {_, #type: "bom", #value: "14"}
		name:           "Cylinder Head"
		description:    "Component \"cylinder head\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "CYL.#503069"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "14"}
	}

	bom14: {
		id: utils.uuid & {_, #type: "bom", #value: "15"}
		name:           "Frame"
		description:    "Component \"frame\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "FRA.#947725"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "15"}
	}

	bom15: {
		id: utils.uuid & {_, #type: "bom", #value: "16"}
		name:           "Front Brake Master Cylinder"
		description:    "Component \"front brake master cylinder\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "FRO.#291634"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "16"}
	}

	bom16: {
		id: utils.uuid & {_, #type: "bom", #value: "17"}
		name:           "Front Brake-Caliper"
		description:    "Component \"front brake-caliper\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "FROCAL.#232528"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "17"}
	}

	bom17: {
		id: utils.uuid & {_, #type: "bom", #value: "18"}
		name:           "Front Cover / Leg Shield"
		description:    "Component \"front cover / leg shield\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "FRO.#646679"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "18"}
	}

	bom18: {
		id: utils.uuid & {_, #type: "bom", #value: "19"}
		name:           "front fender"
		description:    "Component \"front fender\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "FRO.#417159"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "32"}
	}

	bom19: {
		id: utils.uuid & {_, #type: "bom", #value: "20"}
		name:           "rear fender"
		description:    "Component \"rear fender\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "REA.#382980"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "52"}
	}

	bom20: {
		id: utils.uuid & {_, #type: "bom", #value: "21"}
		name:           "front fork"
		description:    "Component \"front fork\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "FRO.#611893"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "84"}
	}

	bom21: {
		id: utils.uuid & {_, #type: "bom", #value: "22"}
		name:           "rear shock absorber"
		description:    "Component \"rear shock absorber\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "REA.#060545"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "105"}
	}

	bom22: {
		id: utils.uuid & {_, #type: "bom", #value: "23"}
		name:           "front wheel"
		description:    "Component \"front wheel\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "FRO.#072515"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "117"}
	}

	bom23: {
		id: utils.uuid & {_, #type: "bom", #value: "24"}
		name:           "rear wheel"
		description:    "Component \"rear wheel\" for 2024 Honda Motorcycle C125A 2AC - SUPER CUB C125 model."
		outputQuantity: 1
		sku:            "REA.#682714"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "132"}
	}

	bom24: {
		id: utils.uuid & {_, #type: "bom", #value: "25"}
		name:           "Honda Motorcycle C125A 2AC"
		description:    "Honda Motorcycle C125A 2AC - Assembled parts"
		outputQuantity: 1
		sku:            "HND.C125A2AC"
		bomType:        "FINAL_PRODUCT"
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "154"}
	}

}

Bom: {
	items: [
		for k, v in #Bom {
			v
		},
	]
}
