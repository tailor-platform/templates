package master

import (
	"tailor.build/template/seed/utils"
)

#Bom: {
	bom0: {
		id: utils.uuid & {_, #type: "bom", #value: "1"}
		name:           "Front Crown Panel"
		description:    "Front crown fabric panel for Ace Iconic Performance Hat."
		outputQuantity: 1
		sku:            "HAT.BOM.#500001"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "1"}
	}

	bom1: {
		id: utils.uuid & {_, #type: "bom", #value: "2"}
		name:           "Rear Crown Panel"
		description:    "Rear crown fabric panel for Ace Iconic Performance Hat."
		outputQuantity: 1
		sku:            "HAT.BOM.#500002"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "2"}
	}

	// Bom 2..23 with realistic sub-component names:

	bom2: {
		id: utils.uuid & {_, #type: "bom", #value: "3"}
		name:           "Left Side Crown Panel"
		description:    "Left side crown fabric panel for Ace Iconic Performance Hat."
		outputQuantity: 1
		sku:            "HAT.BOM.#500003"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "3"}
	}

	bom3: {
		id: utils.uuid & {_, #type: "bom", #value: "4"}
		name:           "Right Side Crown Panel"
		description:    "Right side crown fabric panel for Ace Iconic Performance Hat."
		outputQuantity: 1
		sku:            "HAT.BOM.#500004"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "4"}
	}

	bom4: {
		id: utils.uuid & {_, #type: "bom", #value: "5"}
		name:           "Left Rear Crown Mesh Panel"
		description:    "Left rear mesh panel for enhanced breathability."
		outputQuantity: 1
		sku:            "HAT.BOM.#500005"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "5"}
	}

	bom5: {
		id: utils.uuid & {_, #type: "bom", #value: "6"}
		name:           "Right Rear Crown Mesh Panel"
		description:    "Right rear mesh panel for enhanced breathability."
		outputQuantity: 1
		sku:            "HAT.BOM.#500006"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "6"}
	}

	bom6: {
		id: utils.uuid & {_, #type: "bom", #value: "7"}
		name:           "Visor Top Fabric"
		description:    "Top layer fabric of the visor."
		outputQuantity: 1
		sku:            "HAT.BOM.#500007"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "7"}
	}

	bom7: {
		id: utils.uuid & {_, #type: "bom", #value: "8"}
		name:           "Visor Bottom Fabric"
		description:    "Underside fabric of the visor to reduce glare."
		outputQuantity: 1
		sku:            "HAT.BOM.#500008"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "8"}
	}

	bom8: {
		id: utils.uuid & {_, #type: "bom", #value: "9"}
		name:           "Visor Stiffener"
		description:    "Stiffening material inserted between visor fabrics."
		outputQuantity: 1
		sku:            "HAT.BOM.#500009"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "9"}
	}

	bom9: {
		id: utils.uuid & {_, #type: "bom", #value: "10"}
		name:           "Sweatband"
		description:    "Moisture-wicking sweatband for comfort."
		outputQuantity: 1
		sku:            "HAT.BOM.#500010"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "10"}
	}

	bom10: {
		id: utils.uuid & {_, #type: "bom", #value: "11"}
		name:           "Closure Strap"
		description:    "Adjustable strap for hat sizing."
		outputQuantity: 1
		sku:            "HAT.BOM.#500011"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "11"}
	}

	bom11: {
		id: utils.uuid & {_, #type: "bom", #value: "12"}
		name:           "Closure Buckle"
		description:    "Metal or plastic buckle for strap closure."
		outputQuantity: 1
		sku:            "HAT.BOM.#500012"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "12"}
	}

	bom12: {
		id: utils.uuid & {_, #type: "bom", #value: "13"}
		name:           "Embroidered Eyelets"
		description:    "Embroidered vents on the crown for breathability."
		outputQuantity: 6
		sku:            "HAT.BOM.#500013"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "13"}
	}

	bom13: {
		id: utils.uuid & {_, #type: "bom", #value: "14"}
		name:           "Top Button"
		description:    "Button at the crown's apex."
		outputQuantity: 1
		sku:            "HAT.BOM.#500014"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "14"}
	}

	bom14: {
		id: utils.uuid & {_, #type: "bom", #value: "15"}
		name:           "Interior Seam Tape"
		description:    "Tape covering the interior seams of the crown panels."
		outputQuantity: 5
		sku:            "HAT.BOM.#500015"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "15"}
	}

	bom15: {
		id: utils.uuid & {_, #type: "bom", #value: "16"}
		name:           "Foam Stabilizer"
		description:    "Foam backing to maintain crown shape."
		outputQuantity: 1
		sku:            "HAT.BOM.#500016"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "16"}
	}

	bom16: {
		id: utils.uuid & {_, #type: "bom", #value: "17"}
		name:           "Brand Label"
		description:    "Woven brand label attached inside the hat."
		outputQuantity: 1
		sku:            "HAT.BOM.#500017"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "17"}
	}

	bom17: {
		id: utils.uuid & {_, #type: "bom", #value: "18"}
		name:           "Care Label"
		description:    "Printed label with care instructions."
		outputQuantity: 1
		sku:            "HAT.BOM.#500018"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "18"}
	}

	bom18: {
		id: utils.uuid & {_, #type: "bom", #value: "19"}
		name:           "Front Logo Patch"
		description:    "Embroidered logo patch placed on the front crown."
		outputQuantity: 1
		sku:            "HAT.BOM.#500019"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "19"}
	}

	bom19: {
		id: utils.uuid & {_, #type: "bom", #value: "20"}
		name:           "Back Logo Patch"
		description:    "Small embroidered logo patch at the back of the hat."
		outputQuantity: 1
		sku:            "HAT.BOM.#500020"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "20"}
	}

	bom20: {
		id: utils.uuid & {_, #type: "bom", #value: "21"}
		name:           "Side Logo Patch"
		description:    "Optional embroidered patch placed on the side panel."
		outputQuantity: 1
		sku:            "HAT.BOM.#500021"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "21"}
	}

	bom21: {
		id: utils.uuid & {_, #type: "bom", #value: "22"}
		name:           "Decorative Piping"
		description:    "Piping around crown seams for added style."
		outputQuantity: 1
		sku:            "HAT.BOM.#500022"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "22"}
	}

	bom22: {
		id: utils.uuid & {_, #type: "bom", #value: "23"}
		name:           "Thread Spool"
		description:    "High-strength thread used for stitching the panels."
		outputQuantity: 1
		sku:            "HAT.BOM.#500023"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "23"}
	}

	bom23: {
		id: utils.uuid & {_, #type: "bom", #value: "24"}
		name:           "Under-Visor Fabric"
		description:    "Additional under-visor lining for support and style."
		outputQuantity: 1
		sku:            "HAT.BOM.#500024"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "24"}
	}

	// The final assembled hat:
	bom24: {
		id: utils.uuid & {_, #type: "bom", #value: "25"}
		name:           "Ace Iconic Performance Hat"
		description:    "Ace Iconic Performance Hat - Assembled parts"
		outputQuantity: 1
		sku:            "ACE.HAT"
		bomType:        "FINAL_PRODUCT"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		itemId:         utils.uuid & {_, #type: "item", #value: "154"}
	}
}

Bom: {
	items: [
		for k, v in #Bom {
			v
		},
	]
}
