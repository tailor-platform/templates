package master

import (
	"tailor.build/template/seed/utils"
)

#Item: {

	// 1. FRONT CROWN PANEL
	item0: {
		id: utils.uuid & {_, #type: "item", #value: "1"}
		name:           "Front Crown Panel"
		description:    "Front crown fabric panel for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100001"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 10
		wastedQuantity: 10
		scrapAction:    "Return"
	}

	// 2. REAR CROWN PANEL
	item1: {
		id: utils.uuid & {_, #type: "item", #value: "2"}
		name:           "Rear Crown Panel"
		description:    "Rear crown fabric panel for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100002"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 3. LEFT SIDE CROWN PANEL
	item2: {
		id: utils.uuid & {_, #type: "item", #value: "3"}
		name:           "Left Side Crown Panel"
		description:    "Left side fabric panel for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100003"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 4. RIGHT SIDE CROWN PANEL
	item3: {
		id: utils.uuid & {_, #type: "item", #value: "4"}
		name:           "Right Side Crown Panel"
		description:    "Right side fabric panel for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100004"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 5. TOP BUTTON
	item4: {
		id: utils.uuid & {_, #type: "item", #value: "5"}
		name:           "Top Button"
		description:    "Top button piece for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100005"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 6. VISOR CANVAS
	item5: {
		id: utils.uuid & {_, #type: "item", #value: "6"}
		name:           "Visor Canvas"
		description:    "Outer visor fabric for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100006"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 7. VISOR INSERT
	item6: {
		id: utils.uuid & {_, #type: "item", #value: "7"}
		name:           "Visor Insert"
		description:    "Plastic insert to shape the visor for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100007"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 8. SWEATBAND FABRIC
	item7: {
		id: utils.uuid & {_, #type: "item", #value: "8"}
		name:           "Sweatband Fabric"
		description:    "Comfort sweatband fabric for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100008"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 9. SWEATBAND ELASTIC
	item8: {
		id: utils.uuid & {_, #type: "item", #value: "9"}
		name:           "Sweatband Elastic"
		description:    "Elastic material for sweatband adjustment in Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100009"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 10. ADJUSTABLE BACK STRAP
	item9: {
		id: utils.uuid & {_, #type: "item", #value: "10"}
		name:           "Adjustable Back Strap"
		description:    "Adjustable back strap for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100010"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 11. SNAPBACK CLOSURE
	item10: {
		id: utils.uuid & {_, #type: "item", #value: "11"}
		name:           "Snapback Closure"
		description:    "Snapback plastic closure for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100011"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 12. BUCKLES AND METAL RINGS
	item11: {
		id: utils.uuid & {_, #type: "item", #value: "12"}
		name:           "Buckles and Metal Rings"
		description:    "Metal buckles and rings for hat adjustment hardware."
		sku:            "HAT.COMP.#100012"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 13. LOGO PATCH EMBROIDERED
	item12: {
		id: utils.uuid & {_, #type: "item", #value: "13"}
		name:           "Logo Patch (Embroidered)"
		description:    "Embroidered logo patch for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100013"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 14. ACCENT STITCHING THREAD
	item13: {
		id: utils.uuid & {_, #type: "item", #value: "14"}
		name:           "Accent Stitching Thread"
		description:    "Colored thread for accent stitching on Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100014"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 15. EYELETS PACK (LARGE)
	item14: {
		id: utils.uuid & {_, #type: "item", #value: "15"}
		name:           "Eyelets Pack (Large)"
		description:    "Metal eyelets for ventilation holes in Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100015"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 16. FOAM REINFORCEMENT
	item15: {
		id: utils.uuid & {_, #type: "item", #value: "16"}
		name:           "Foam Reinforcement"
		description:    "Foam reinforcement for hat structure."
		sku:            "HAT.COMP.#100016"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 17. INTERLINING MATERIAL
	item16: {
		id: utils.uuid & {_, #type: "item", #value: "17"}
		name:           "Interlining Material"
		description:    "Interlining for improved shape retention in Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100017"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 18. BRAND LABEL (WOVEN)
	item17: {
		id: utils.uuid & {_, #type: "item", #value: "18"}
		name:           "Brand Label (Woven)"
		description:    "Woven brand label for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100018"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 19. SIZE LABEL
	item18: {
		id: utils.uuid & {_, #type: "item", #value: "19"}
		name:           "Size Label"
		description:    "Size indicator label for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100019"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 20. CARE INSTRUCTION LABEL
	item19: {
		id: utils.uuid & {_, #type: "item", #value: "20"}
		name:           "Care Instruction Label"
		description:    "Printed label with care instructions for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100020"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 21. HANG TAG CORD
	item20: {
		id: utils.uuid & {_, #type: "item", #value: "21"}
		name:           "Hang Tag Cord"
		description:    "Cord for attaching hang tag to Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100021"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 22. HANG TAG PAPER
	item21: {
		id: utils.uuid & {_, #type: "item", #value: "22"}
		name:           "Hang Tag Paper"
		description:    "Paper hang tag for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100022"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 23. DECORATIVE RIBBON
	item22: {
		id: utils.uuid & {_, #type: "item", #value: "23"}
		name:           "Decorative Ribbon"
		description:    "Ribbon for hat decoration on Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100023"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 24. UNDERBILL PRINT TRANSFER
	item23: {
		id: utils.uuid & {_, #type: "item", #value: "24"}
		name:           "Underbill Print Transfer"
		description:    "Graphics transfer for underbill decoration on Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100024"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 25. BUTTON CORD
	item24: {
		id: utils.uuid & {_, #type: "item", #value: "25"}
		name:           "Button Cord"
		description:    "Cord used to secure top button on Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100025"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 26. VISOR REINFORCEMENT STRIP
	item25: {
		id: utils.uuid & {_, #type: "item", #value: "26"}
		name:           "Visor Reinforcement Strip"
		description:    "Extra reinforcement strip for hat visor."
		sku:            "HAT.COMP.#100026"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 27. FOAM PADDING
	item26: {
		id: utils.uuid & {_, #type: "item", #value: "27"}
		name:           "Foam Padding"
		description:    "Additional foam padding for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100027"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 28. HOLOGRAPHIC STICKER
	item27: {
		id: utils.uuid & {_, #type: "item", #value: "28"}
		name:           "Holographic Sticker"
		description:    "Holographic sticker for authenticity on Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100028"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 29. REFLECTIVE PATCH
	item28: {
		id: utils.uuid & {_, #type: "item", #value: "29"}
		name:           "Reflective Patch"
		description:    "Reflective patch for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100029"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 30. CROWN VENTILATION MESH
	item29: {
		id: utils.uuid & {_, #type: "item", #value: "30"}
		name:           "Crown Ventilation Mesh"
		description:    "Breathable mesh material for crown ventilation in Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100030"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 31. PERFORMANCE SWEATBAND INSERT
	item30: {
		id: utils.uuid & {_, #type: "item", #value: "31"}
		name:           "Performance Sweatband Insert"
		description:    "High-performance moisture-wicking sweatband insert for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100031"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 32. CROWN STRUCTURE SUPPORT
	item31: {
		id: utils.uuid & {_, #type: "item", #value: "32"}
		name:           "Crown Structure Support"
		description:    "Internal support material for maintaining crown shape."
		sku:            "HAT.COMP.#100032"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 33. SIDE PANEL MESH INSERT
	item32: {
		id: utils.uuid & {_, #type: "item", #value: "33"}
		name:           "Side Panel Mesh Insert"
		description:    "Breathable mesh inserts for side panels of Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100033"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 34. REAR VENTILATION GROMMETS
	item33: {
		id: utils.uuid & {_, #type: "item", #value: "34"}
		name:           "Rear Ventilation Grommets"
		description:    "Metal grommets for rear panel ventilation."
		sku:            "HAT.COMP.#100034"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 35. PREMIUM CLOSURE SYSTEM
	item34: {
		id: utils.uuid & {_, #type: "item", #value: "35"}
		name:           "Premium Closure System"
		description:    "High-quality adjustable closure system for perfect fit."
		sku:            "HAT.COMP.#100035"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 36. VISOR STIFFENING INSERT
	item35: {
		id: utils.uuid & {_, #type: "item", #value: "36"}
		name:           "Visor Stiffening Insert"
		description:    "Reinforcement insert for visor shape retention."
		sku:            "HAT.COMP.#100036"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 37. MOISTURE-WICKING HEADBAND
	item36: {
		id: utils.uuid & {_, #type: "item", #value: "37"}
		name:           "Moisture-Wicking Headband"
		description:    "Advanced moisture-wicking headband for comfort."
		sku:            "HAT.COMP.#100037"
		isFinalProduct: false
		inventoryType:  "INVENTORY" 
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 38. CROWN REINFORCEMENT TAPE
	item37: {
		id: utils.uuid & {_, #type: "item", #value: "38"}
		name:           "Crown Reinforcement Tape"
		description:    "Structural reinforcement tape for crown stability."
		sku:            "HAT.COMP.#100038"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 39. SIDE PANEL STABILIZER
	item38: {
		id: utils.uuid & {_, #type: "item", #value: "39"}
		name:           "Side Panel Stabilizer"
		description:    "Support material for side panel structure."
		sku:            "HAT.COMP.#100039"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 40. PERFORMANCE MESH LINING
	item39: {
		id: utils.uuid & {_, #type: "item", #value: "40"}
		name:           "Performance Mesh Lining"
		description:    "Breathable mesh lining for internal comfort."
		sku:            "HAT.COMP.#100040"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 41. VISOR EDGE BINDING
	item40: {
		id: utils.uuid & {_, #type: "item", #value: "41"}
		name:           "Visor Edge Binding"
		description:    "Protective binding for visor edges."
		sku:            "HAT.COMP.#100041"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 42. CROWN VENTILATION PANEL
	item41: {
		id: utils.uuid & {_, #type: "item", #value: "42"}
		name:           "Crown Ventilation Panel"
		description:    "Specialized panel for crown airflow."
		sku:            "HAT.COMP.#100042"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 43. REFLECTIVE SAFETY STRIP
	item42: {
		id: utils.uuid & {_, #type: "item", #value: "43"}
		name:           "Reflective Safety Strip"
		description:    "High-visibility reflective material for safety."
		sku:            "HAT.COMP.#100043"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 44. QUICK-DRY SWEATBAND
	item43: {
		id: utils.uuid & {_, #type: "item", #value: "44"}
		name:           "Quick-Dry Sweatband"
		description:    "Rapid moisture-wicking sweatband material."
		sku:            "HAT.COMP.#100044"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 45. ANTI-MICROBIAL TREATMENT
	item44: {
		id: utils.uuid & {_, #type: "item", #value: "45"}
		name:           "Anti-Microbial Treatment"
		description:    "Protective treatment for odor control."
		sku:            "HAT.COMP.#100045"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 46. UV PROTECTION COATING
	item45: {
		id: utils.uuid & {_, #type: "item", #value: "46"}
		name:           "UV Protection Coating"
		description:    "Specialized UV-resistant coating for fabric protection."
		sku:            "HAT.COMP.#100046"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 47. ELASTIC COMFORT BAND
	item46: {
		id: utils.uuid & {_, #type: "item", #value: "47"}
		name:           "Elastic Comfort Band"
		description:    "Flexible band for improved fit and comfort."
		sku:            "HAT.COMP.#100047"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 48. CROWN HEIGHT STABILIZER
	item47: {
		id: utils.uuid & {_, #type: "item", #value: "48"}
		name:           "Crown Height Stabilizer"
		description:    "Internal support for maintaining crown height."
		sku:            "HAT.COMP.#100048"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 49. REAR MESH PANEL
	item48: {
		id: utils.uuid & {_, #type: "item", #value: "49"}
		name:           "Rear Mesh Panel"
		description:    "Breathable mesh panel for back section."
		sku:            "HAT.COMP.#100049"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 50. PREMIUM SNAP CLOSURE
	item49: {
		id: utils.uuid & {_, #type: "item", #value: "50"}
		name:           "Premium Snap Closure"
		description:    "High-quality snap closure system."
		sku:            "HAT.COMP.#100050"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 51. REINFORCED SEAM TAPE
	item50: {
		id: utils.uuid & {_, #type: "item", #value: "51"}
		name:           "Reinforced Seam Tape"
		description:    "Heavy-duty tape for seam reinforcement."
		sku:            "HAT.COMP.#100051"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 52. MOISTURE BARRIER LAYER
	item51: {
		id: utils.uuid & {_, #type: "item", #value: "52"}
		name:           "Moisture Barrier Layer"
		description:    "Protective moisture-resistant layer."
		sku:            "HAT.COMP.#100052"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 53. VISOR SHAPE RETAINER
	item52: {
		id: utils.uuid & {_, #type: "item", #value: "53"}
		name:           "Visor Shape Retainer"
		description:    "Internal support for visor shape maintenance."
		sku:            "HAT.COMP.#100053"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 54. COMFORT FOAM INSERT
	item53: {
		id: utils.uuid & {_, #type: "item", #value: "54"}
		name:           "Comfort Foam Insert"
		description:    "Cushioning foam for enhanced comfort."
		sku:            "HAT.COMP.#100054"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 55. VENTILATION EYELET SET
	item54: {
		id: utils.uuid & {_, #type: "item", #value: "55"}
		name:           "Ventilation Eyelet Set"
		description:    "Metal eyelets for enhanced airflow."
		sku:            "HAT.COMP.#100055"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	//
	// Now continue items #56 through #152 (item55..item151) in the same pattern
	// (unique realistic sub-component names, consistent true/false pattern).
	//

	// 56. CROWN WEATHER PROTECTOR
	item55: {
		id: utils.uuid & {_, #type: "item", #value: "56"}
		name:           "Crown Weather Protector"
		description:    "Layer for shielding crown fabric from wet conditions."
		sku:            "HAT.COMP.#100056"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 57. NEON ACCENT STITCH
	item56: {
		id: utils.uuid & {_, #type: "item", #value: "57"}
		name:           "Neon Accent Stitch"
		description:    "Bright stitching thread for high-visibility detailing."
		sku:            "HAT.COMP.#100057"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 58. SWEATBAND SILICONE STRIP
	item57: {
		id: utils.uuid & {_, #type: "item", #value: "58"}
		name:           "Sweatband Silicone Strip"
		description:    "Non-slip silicone strip for sweatband interior."
		sku:            "HAT.COMP.#100058"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 59. RIVETED METAL EYELET
	item58: {
		id: utils.uuid & {_, #type: "item", #value: "59"}
		name:           "Riveted Metal Eyelet"
		description:    "Sturdy metal eyelet for improved durability."
		sku:            "HAT.COMP.#100059"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 60. ULTRA-FIT SWEATBAND
	item59: {
		id: utils.uuid & {_, #type: "item", #value: "60"}
		name:           "Ultra-Fit Sweatband"
		description:    "Premium sweatband designed for ultra comfort and moisture control."
		sku:            "HAT.COMP.#100060"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 61. DECORATIVE SIDE PATCH
	item60: {
		id: utils.uuid & {_, #type: "item", #value: "61"}
		name:           "Decorative Side Patch"
		description:    "Emblem patch for side panel decoration."
		sku:            "HAT.COMP.#100061"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 62. ANTI-GLARE VISOR STRIP
	item61: {
		id: utils.uuid & {_, #type: "item", #value: "62"}
		name:           "Anti-Glare Visor Strip"
		description:    "Special strip on visor underside to reduce glare."
		sku:            "HAT.COMP.#100062"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 63. SIDE LOGO TRANSFER
	item62: {
		id: utils.uuid & {_, #type: "item", #value: "63"}
		name:           "Side Logo Transfer"
		description:    "Heat transfer for adding a small side logo."
		sku:            "HAT.COMP.#100063"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 64. EDGE GUARD PIPING
	item63: {
		id: utils.uuid & {_, #type: "item", #value: "64"}
		name:           "Edge Guard Piping"
		description:    "Protective piping to guard edges from wear."
		sku:            "HAT.COMP.#100064"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 65. HYDROPHOBIC CROWN FABRIC
	item64: {
		id: utils.uuid & {_, #type: "item", #value: "65"}
		name:           "Hydrophobic Crown Fabric"
		description:    "Water-repellent crown fabric for outdoor performance."
		sku:            "HAT.COMP.#100065"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 66. REFLECTIVE VISOR LOGO
	item65: {
		id: utils.uuid & {_, #type: "item", #value: "66"}
		name:           "Reflective Visor Logo"
		description:    "Small reflective logo attachment for visor top."
		sku:            "HAT.COMP.#100066"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 67. INTERIOR SEAM COVER
	item66: {
		id: utils.uuid & {_, #type: "item", #value: "67"}
		name:           "Interior Seam Cover"
		description:    "Soft tape covering internal seams for comfort."
		sku:            "HAT.COMP.#100067"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 68. COOLING MESH OVERLAY
	item67: {
		id: utils.uuid & {_, #type: "item", #value: "68"}
		name:           "Cooling Mesh Overlay"
		description:    "Special overlay mesh for improved ventilation."
		sku:            "HAT.COMP.#100068"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 69. GLITTER ACCENT THREAD
	item68: {
		id: utils.uuid & {_, #type: "item", #value: "69"}
		name:           "Glitter Accent Thread"
		description:    "Subtle glitter thread for decorative stitching."
		sku:            "HAT.COMP.#100069"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 70. PREMIUM BRANDED PATCH
	item69: {
		id: utils.uuid & {_, #type: "item", #value: "70"}
		name:           "Premium Branded Patch"
		description:    "High-end embroidered patch showcasing brand logo."
		sku:            "HAT.COMP.#100070"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 71. HIDDEN STORAGE POCKET
	item70: {
		id: utils.uuid & {_, #type: "item", #value: "71"}
		name:           "Hidden Storage Pocket"
		description:    "Secret pocket within crown for small valuables."
		sku:            "HAT.COMP.#100071"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 72. LINING ANTI-STATIC STRIP
	item71: {
		id: utils.uuid & {_, #type: "item", #value: "72"}
		name:           "Lining Anti-Static Strip"
		description:    "Strip to reduce static buildup in hat lining."
		sku:            "HAT.COMP.#100072"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 73. SIDE-VENT REFLECTIVE PANEL
	item72: {
		id: utils.uuid & {_, #type: "item", #value: "73"}
		name:           "Side-Vent Reflective Panel"
		description:    "Reflective panel for increased visibility on side vents."
		sku:            "HAT.COMP.#100073"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 74. VISOR GRIP TEXTURE
	item73: {
		id: utils.uuid & {_, #type: "item", #value: "74"}
		name:           "Visor Grip Texture"
		description:    "Rubberized texture on visor brim for better grip."
		sku:            "HAT.COMP.#100074"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 75. HEAT TRANSFER BRANDING
	item74: {
		id: utils.uuid & {_, #type: "item", #value: "75"}
		name:           "Heat Transfer Branding"
		description:    "Branded graphic applied via heat transfer technology."
		sku:            "HAT.COMP.#100075"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 76. ODOR-NEUTRALIZING LINER
	item75: {
		id: utils.uuid & {_, #type: "item", #value: "76"}
		name:           "Odor-Neutralizing Liner"
		description:    "Special liner to reduce and neutralize sweat odors."
		sku:            "HAT.COMP.#100076"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 77. FOAM SHOCK ABSORBER
	item76: {
		id: utils.uuid & {_, #type: "item", #value: "77"}
		name:           "Foam Shock Absorber"
		description:    "Additional foam to absorb impact on top of hat."
		sku:            "HAT.COMP.#100077"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 78. WRAPAROUND ELASTIC BAND
	item77: {
		id: utils.uuid & {_, #type: "item", #value: "78"}
		name:           "Wraparound Elastic Band"
		description:    "Elastic band providing secure fit around entire head."
		sku:            "HAT.COMP.#100078"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 79. DUAL-COLOR VISOR FABRIC
	item78: {
		id: utils.uuid & {_, #type: "item", #value: "79"}
		name:           "Dual-Color Visor Fabric"
		description:    "Contrasting colors on top and bottom of visor."
		sku:            "HAT.COMP.#100079"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 80. HIGH-DEFINITION LOGO PATCH
	item79: {
		id: utils.uuid & {_, #type: "item", #value: "80"}
		name:           "High-Definition Logo Patch"
		description:    "Raised embroidered patch with crisp detail."
		sku:            "HAT.COMP.#100080"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 81. PERFORATED SIDE STRAP
	item80: {
		id: utils.uuid & {_, #type: "item", #value: "81"}
		name:           "Perforated Side Strap"
		description:    "Adjustable strap with perforations for added airflow."
		sku:            "HAT.COMP.#100081"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 82. INTERIOR SILK LINING
	item81: {
		id: utils.uuid & {_, #type: "item", #value: "82"}
		name:           "Interior Silk Lining"
		description:    "Luxurious silk lining for enhanced comfort and style."
		sku:            "HAT.COMP.#100082"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 83. REAR REFLECTIVE LABEL
	item82: {
		id: utils.uuid & {_, #type: "item", #value: "83"}
		name:           "Rear Reflective Label"
		description:    "Reflective brand label on rear panel for night visibility."
		sku:            "HAT.COMP.#100083"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 84. AROMA-INFUSED HEADBAND
	item83: {
		id: utils.uuid & {_, #type: "item", #value: "84"}
		name:           "Aroma-Infused Headband"
		description:    "Headband subtly infused with pleasant aroma technology."
		sku:            "HAT.COMP.#100084"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 85. WIND-RESISTANT PANEL
	item84: {
		id: utils.uuid & {_, #type: "item", #value: "85"}
		name:           "Wind-Resistant Panel"
		description:    "Special panel for preventing wind infiltration."
		sku:            "HAT.COMP.#100085"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 86. SPORTY DECAL PRINT
	item85: {
		id: utils.uuid & {_, #type: "item", #value: "86"}
		name:           "Sporty Decal Print"
		description:    "Colorful decal for sporty aesthetic on hat exterior."
		sku:            "HAT.COMP.#100086"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 87. QUICK-RELEASE BUCKLE
	item86: {
		id: utils.uuid & {_, #type: "item", #value: "87"}
		name:           "Quick-Release Buckle"
		description:    "Buckle allowing fast release and adjustment."
		sku:            "HAT.COMP.#100087"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 88. MESH OVERLAY STRIPES
	item87: {
		id: utils.uuid & {_, #type: "item", #value: "88"}
		name:           "Mesh Overlay Stripes"
		description:    "Decorative stripes of mesh overlay for style and airflow."
		sku:            "HAT.COMP.#100088"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 89. MID-CROWN SUPPORT BAND
	item88: {
		id: utils.uuid & {_, #type: "item", #value: "89"}
		name:           "Mid-Crown Support Band"
		description:    "Support band around the mid-crown area for shape retention."
		sku:            "HAT.COMP.#100089"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 90. LUXE EMBROIDERED PATCH
	item89: {
		id: utils.uuid & {_, #type: "item", #value: "90"}
		name:           "Luxe Embroidered Patch"
		description:    "Premium embroidered patch with metallic thread."
		sku:            "HAT.COMP.#100090"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 91. PERFORMANCE COOLING BAND
	item90: {
		id: utils.uuid & {_, #type: "item", #value: "91"}
		name:           "Performance Cooling Band"
		description:    "Cooling band to reduce internal heat build-up."
		sku:            "HAT.COMP.#100091"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 92. FLEXIBLE VISOR BASE
	item91: {
		id: utils.uuid & {_, #type: "item", #value: "92"}
		name:           "Flexible Visor Base"
		description:    "Semi-rigid yet flexible base layer for the visor."
		sku:            "HAT.COMP.#100092"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 93. ANTI-SWEAT LINING
	item92: {
		id: utils.uuid & {_, #type: "item", #value: "93"}
		name:           "Anti-Sweat Lining"
		description:    "Extra lining to prevent sweat marks."
		sku:            "HAT.COMP.#100093"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 94. REAR SIZE ADJUSTER
	item93: {
		id: utils.uuid & {_, #type: "item", #value: "94"}
		name:           "Rear Size Adjuster"
		description:    "Mechanism for adjusting fit at the rear crown."
		sku:            "HAT.COMP.#100094"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 95. FOIL DECOR LOGO
	item94: {
		id: utils.uuid & {_, #type: "item", #value: "95"}
		name:           "Foil Decor Logo"
		description:    "Metallic foil decoration highlighting brand logo."
		sku:            "HAT.COMP.#100095"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 96. LASER-CUT VENT PANELS
	item95: {
		id: utils.uuid & {_, #type: "item", #value: "96"}
		name:           "Laser-Cut Vent Panels"
		description:    "Precision laser-cut vents for improved airflow."
		sku:            "HAT.COMP.#100096"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 97. TPU LOGO BADGE
	item96: {
		id: utils.uuid & {_, #type: "item", #value: "97"}
		name:           "TPU Logo Badge"
		description:    "Thermoplastic polyurethane badge for brand marking."
		sku:            "HAT.COMP.#100097"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 98. REINFORCED BUTTON LOOP
	item97: {
		id: utils.uuid & {_, #type: "item", #value: "98"}
		name:           "Reinforced Button Loop"
		description:    "Strengthened loop to secure top button firmly."
		sku:            "HAT.COMP.#100098"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 99. NEOPRENE SWEAT GUARD
	item98: {
		id: utils.uuid & {_, #type: "item", #value: "99"}
		name:           "Neoprene Sweat Guard"
		description:    "Neoprene guard to protect from sweat absorption."
		sku:            "HAT.COMP.#100099"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 100. EMBOSSED LEATHER LABEL
	item99: {
		id: utils.uuid & {_, #type: "item", #value: "100"}
		name:           "Embossed Leather Label"
		description:    "Genuine leather label with embossed brand design."
		sku:            "HAT.COMP.#100100"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 101. REAR ELASTIC DRAWSTRINGS
	item100: {
		id: utils.uuid & {_, #type: "item", #value: "101"}
		name:           "Rear Elastic Drawstrings"
		description:    "Elastic drawstring for adjusting hat tightness at rear."
		sku:            "HAT.COMP.#100101"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 102. PRINTED LOGO TAPING
	item101: {
		id: utils.uuid & {_, #type: "item", #value: "102"}
		name:           "Printed Logo Taping"
		description:    "Branded taping running along hat seams for branding."
		sku:            "HAT.COMP.#100102"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 103. FLAT VISOR INSERT
	item102: {
		id: utils.uuid & {_, #type: "item", #value: "103"}
		name:           "Flat Visor Insert"
		description:    "Insert for achieving a flat visor style."
		sku:            "HAT.COMP.#100103"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 104. SUBTLE ACCENT TRIM
	item103: {
		id: utils.uuid & {_, #type: "item", #value: "104"}
		name:           "Subtle Accent Trim"
		description:    "Thin decorative trim around edges for a subtle pop."
		sku:            "HAT.COMP.#100104"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 105. ENGRAVED METAL EMBLEM
	item104: {
		id: utils.uuid & {_, #type: "item", #value: "105"}
		name:           "Engraved Metal Emblem"
		description:    "Metal emblem with intricate engraved branding."
		sku:            "HAT.COMP.#100105"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 106. REFLECTIVE TAPED SEAMS
	item105: {
		id: utils.uuid & {_, #type: "item", #value: "106"}
		name:           "Reflective Taped Seams"
		description:    "Taped seams with reflective properties for nighttime visibility."
		sku:            "HAT.COMP.#100106"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 107. FELT LINING STRIP
	item106: {
		id: utils.uuid & {_, #type: "item", #value: "107"}
		name:           "Felt Lining Strip"
		description:    "Soft felt strip for added forehead comfort."
		sku:            "HAT.COMP.#100107"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 108. COLOR-CHANGING LOGO
	item107: {
		id: utils.uuid & {_, #type: "item", #value: "108"}
		name:           "Color-Changing Logo"
		description:    "Logo that shifts color under UV light."
		sku:            "HAT.COMP.#100108"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 109. HIGH-TECH FABRIC BLEND
	item108: {
		id: utils.uuid & {_, #type: "item", #value: "109"}
		name:           "High-Tech Fabric Blend"
		description:    "Innovative blend for increased durability and moisture control."
		sku:            "HAT.COMP.#100109"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 110. SUBLIMATED VISOR ART
	item109: {
		id: utils.uuid & {_, #type: "item", #value: "110"}
		name:           "Sublimated Visor Art"
		description:    "Full-color sublimated design on the visor surface."
		sku:            "HAT.COMP.#100110"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 111. HIDDEN REINFORCEMENT WEBBING
	item110: {
		id: utils.uuid & {_, #type: "item", #value: "111"}
		name:           "Hidden Reinforcement Webbing"
		description:    "Webbing within crown for structural integrity."
		sku:            "HAT.COMP.#100111"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 112. SILICONE LOGO APPLIQUÉ
	item111: {
		id: utils.uuid & {_, #type: "item", #value: "112"}
		name:           "Silicone Logo Appliqué"
		description:    "Raised silicone appliqué for bold brand visibility."
		sku:            "HAT.COMP.#100112"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 113. WATERPROOF STITCH SEALANT
	item112: {
		id: utils.uuid & {_, #type: "item", #value: "113"}
		name:           "Waterproof Stitch Sealant"
		description:    "Sealant applied over stitches to prevent water ingress."
		sku:            "HAT.COMP.#100113"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 114. UNDER VISOR REFLECTIVE PRINT
	item113: {
		id: utils.uuid & {_, #type: "item", #value: "114"}
		name:           "Under Visor Reflective Print"
		description:    "Reflective design on the underside of the visor."
		sku:            "HAT.COMP.#100114"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 115. EMBROIDERED CREST PATCH
	item114: {
		id: utils.uuid & {_, #type: "item", #value: "115"}
		name:           "Embroidered Crest Patch"
		description:    "Traditional crest-style patch with fine embroidery."
		sku:            "HAT.COMP.#100115"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 116. FRAY-RESISTANT THREAD
	item115: {
		id: utils.uuid & {_, #type: "item", #value: "116"}
		name:           "Fray-Resistant Thread"
		description:    "Durable thread designed to resist fraying over time."
		sku:            "HAT.COMP.#100116"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 117. LAMINATED VISOR CORE
	item116: {
		id: utils.uuid & {_, #type: "item", #value: "117"}
		name:           "Laminated Visor Core"
		description:    "Multiple layers laminated for a sturdy visor core."
		sku:            "HAT.COMP.#100117"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 118. BREATHABLE INNER NETTING
	item117: {
		id: utils.uuid & {_, #type: "item", #value: "118"}
		name:           "Breathable Inner Netting"
		description:    "Light netting for improved internal airflow."
		sku:            "HAT.COMP.#100118"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 119. MICROFLEECE WRAP
	item118: {
		id: utils.uuid & {_, #type: "item", #value: "119"}
		name:           "Microfleece Wrap"
		description:    "Soft microfleece wrap around the crown for warmth."
		sku:            "HAT.COMP.#100119"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 120. OVERSIZED EMBLEM FRONT
	item119: {
		id: utils.uuid & {_, #type: "item", #value: "120"}
		name:           "Oversized Emblem Front"
		description:    "Large embroidered emblem occupying most of front panel."
		sku:            "HAT.COMP.#100120"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 121. DUAL-DENSITY FOAM LAYER
	item120: {
		id: utils.uuid & {_, #type: "item", #value: "121"}
		name:           "Dual-Density Foam Layer"
		description:    "Foam layer with two densities for comfort and support."
		sku:            "HAT.COMP.#100121"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 122. HIGHLIGHTED TOP STITCH
	item121: {
		id: utils.uuid & {_, #type: "item", #value: "122"}
		name:           "Highlighted Top Stitch"
		description:    "Eye-catching color for top button and topstitching."
		sku:            "HAT.COMP.#100122"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 123. COMPRESSION HEADBAND LAYER
	item122: {
		id: utils.uuid & {_, #type: "item", #value: "123"}
		name:           "Compression Headband Layer"
		description:    "Elastic compression layer to ensure secure head fit."
		sku:            "HAT.COMP.#100123"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 124. DECORATIVE PEAK ACCENT
	item123: {
		id: utils.uuid & {_, #type: "item", #value: "124"}
		name:           "Decorative Peak Accent"
		description:    "Contrast accent placed at the front peak of the visor."
		sku:            "HAT.COMP.#100124"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 125. DELUXE METAL BUCKLE
	item124: {
		id: utils.uuid & {_, #type: "item", #value: "125"}
		name:           "Deluxe Metal Buckle"
		description:    "Top-tier metal buckle for adjustable strap with premium finish."
		sku:            "HAT.COMP.#100125"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 126. MESH INTERIOR PARTITION
	item125: {
		id: utils.uuid & {_, #type: "item", #value: "126"}
		name:           "Mesh Interior Partition"
		description:    "Partition inside hat for separating compartments."
		sku:            "HAT.COMP.#100126"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 127. 3D RAISED FRONT LETTERING
	item126: {
		id: utils.uuid & {_, #type: "item", #value: "127"}
		name:           "3D Raised Front Lettering"
		description:    "Three-dimensional lettering for bold brand presence."
		sku:            "HAT.COMP.#100127"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 128. DUAL-LAYER SWEAT GUARD
	item127: {
		id: utils.uuid & {_, #type: "item", #value: "128"}
		name:           "Dual-Layer Sweat Guard"
		description:    "Two-layer system to wick sweat and prevent staining."
		sku:            "HAT.COMP.#100128"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 129. METALLIC EDGE TRIM
	item128: {
		id: utils.uuid & {_, #type: "item", #value: "129"}
		name:           "Metallic Edge Trim"
		description:    "Shiny metallic trim along the edges for flair."
		sku:            "HAT.COMP.#100129"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 130. HIGH-CROWN FOAM LINER
	item129: {
		id: utils.uuid & {_, #type: "item", #value: "130"}
		name:           "High-Crown Foam Liner"
		description:    "Foam liner specifically for high-crown hat designs."
		sku:            "HAT.COMP.#100130"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 131. LIGHT-REFRACTING BEADWORK
	item130: {
		id: utils.uuid & {_, #type: "item", #value: "131"}
		name:           "Light-Refracting Beadwork"
		description:    "Small beads refracting light, adding sparkle under bright conditions."
		sku:            "HAT.COMP.#100131"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 132. RIGID VISOR SKELETON
	item131: {
		id: utils.uuid & {_, #type: "item", #value: "132"}
		name:           "Rigid Visor Skeleton"
		description:    "Rigid interior visor framework for strong shape definition."
		sku:            "HAT.COMP.#100132"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 133. ENHANCED AIRFLOW BAND
	item132: {
		id: utils.uuid & {_, #type: "item", #value: "133"}
		name:           "Enhanced Airflow Band"
		description:    "Band designed to channel cool air through the interior."
		sku:            "HAT.COMP.#100133"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 134. TEMPERATURE-REGULATING FABRIC
	item133: {
		id: utils.uuid & {_, #type: "item", #value: "134"}
		name:           "Temperature-Regulating Fabric"
		description:    "Fabric that adapts to external temperatures, keeping you comfortable."
		sku:            "HAT.COMP.#100134"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 135. LUXURY SUEDE BRIM
	item134: {
		id: utils.uuid & {_, #type: "item", #value: "135"}
		name:           "Luxury Suede Brim"
		description:    "High-end suede brim for a premium look and feel."
		sku:            "HAT.COMP.#100135"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 136. PATTERNED UNDERBILL FABRIC
	item135: {
		id: utils.uuid & {_, #type: "item", #value: "136"}
		name:           "Patterned Underbill Fabric"
		description:    "Underbill printed with stylish patterns."
		sku:            "HAT.COMP.#100136"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 137. POCKET FOR HEADPHONES
	item136: {
		id: utils.uuid & {_, #type: "item", #value: "137"}
		name:           "Pocket for Headphones"
		description:    "Small concealed pocket to store earbud headphones."
		sku:            "HAT.COMP.#100137"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 138. REFLECTIVE INTERIOR ACCENTS
	item137: {
		id: utils.uuid & {_, #type: "item", #value: "138"}
		name:           "Reflective Interior Accents"
		description:    "Small reflective strips inside hat for subtle shine."
		sku:            "HAT.COMP.#100138"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 139. AROMA-FRESH SWEAT GUARD
	item138: {
		id: utils.uuid & {_, #type: "item", #value: "139"}
		name:           "Aroma-Fresh Sweat Guard"
		description:    "Sweat guard with integrated odor-fighting fragrance."
		sku:            "HAT.COMP.#100139"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 140. SHADOW EMBLEM OUTLINE
	item139: {
		id: utils.uuid & {_, #type: "item", #value: "140"}
		name:           "Shadow Emblem Outline"
		description:    "Outline around emblem for a stylish shadow effect."
		sku:            "HAT.COMP.#100140"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 141. CAMO UNDERBRIM PRINT
	item140: {
		id: utils.uuid & {_, #type: "item", #value: "141"}
		name:           "Camo Underbrim Print"
		description:    "Camouflage print under the visor for a hidden style."
		sku:            "HAT.COMP.#100141"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 142. RIBBON BRAND TAG
	item141: {
		id: utils.uuid & {_, #type: "item", #value: "142"}
		name:           "Ribbon Brand Tag"
		description:    "Small woven ribbon tag with brand name."
		sku:            "HAT.COMP.#100142"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 143. DUAL-TONE CROWN PANEL
	item142: {
		id: utils.uuid & {_, #type: "item", #value: "143"}
		name:           "Dual-Tone Crown Panel"
		description:    "Crown panel featuring two complementary colors."
		sku:            "HAT.COMP.#100143"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 144. STRATEGIC VENT POCKETS
	item143: {
		id: utils.uuid & {_, #type: "item", #value: "144"}
		name:           "Strategic Vent Pockets"
		description:    "Carefully placed vent pockets for optimum air circulation."
		sku:            "HAT.COMP.#100144"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 145. WATER-REPELLENT COATING
	item144: {
		id: utils.uuid & {_, #type: "item", #value: "145"}
		name:           "Water-Repellent Coating"
		description:    "Coating that repels moisture to keep hat drier."
		sku:            "HAT.COMP.#100145"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 146. VINYL SNAP CLOSURE
	item145: {
		id: utils.uuid & {_, #type: "item", #value: "146"}
		name:           "Vinyl Snap Closure"
		description:    "Snap closure made from durable vinyl material."
		sku:            "HAT.COMP.#100146"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 147. LASER-ENGRAVED METAL RING
	item146: {
		id: utils.uuid & {_, #type: "item", #value: "147"}
		name:           "Laser-Engraved Metal Ring"
		description:    "Metal ring hardware with laser-engraved detailing."
		sku:            "HAT.COMP.#100147"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 148. MULTI-LAYER EDGE SEAL
	item147: {
		id: utils.uuid & {_, #type: "item", #value: "148"}
		name:           "Multi-Layer Edge Seal"
		description:    "Edges sealed with multiple layers for durability and style."
		sku:            "HAT.COMP.#100148"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 149. ULTRA-FINE STITCH DETAIL
	item148: {
		id: utils.uuid & {_, #type: "item", #value: "149"}
		name:           "Ultra-Fine Stitch Detail"
		description:    "High stitch-count detail for a refined, premium look."
		sku:            "HAT.COMP.#100149"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 150. GLOW-IN-THE-DARK EMBLEM
	item149: {
		id: utils.uuid & {_, #type: "item", #value: "150"}
		name:           "Glow-in-the-Dark Emblem"
		description:    "Emblem that glows in low-light conditions."
		sku:            "HAT.COMP.#100150"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 151. ULTRA-FLEX COMFORT SWEATBAND
	item150: {
		id: utils.uuid & {_, #type: "item", #value: "151"}
		name:           "Ultra-Flex Comfort Sweatband"
		description:    "Sweatband offering exceptional flexibility and comfort."
		sku:            "HAT.COMP.#100151"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 152. SLIM PROFILE VISOR RIM
	item151: {
		id: utils.uuid & {_, #type: "item", #value: "152"}
		name:           "Slim Profile Visor Rim"
		description:    "Thin rim design offering a sleek visor profile."
		sku:            "HAT.COMP.#100152"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 153. SPECIALTY METAL CLIP
	item152: {
		id: utils.uuid & {_, #type: "item", #value: "153"}
		name:           "Specialty Metal Clip"
		description:    "Unique metal clip accent for Ace Iconic Performance Hat."
		sku:            "HAT.COMP.#100153"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}

	// 154. ACE ICONIC PERFORMANCE HAT (FINAL PRODUCT)
	item153: {
		id: utils.uuid & {_, #type: "item", #value: "154"}
		name:           "Ace Iconic Performance Hat"
		description:    "Ace Iconic Performance Hat - Assembled parts"
		sku:            "ACE.HAT"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		quantity:       10
		woAllocatedQuantity: 0
		wastedQuantity: 0
		scrapAction:    "Return"
	}
}

Item: {
	items: [
		for k, v in #Item {
			v
		},
	]
}
