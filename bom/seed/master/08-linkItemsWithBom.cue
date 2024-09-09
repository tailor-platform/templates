package master

import (
	"tailor.build/template/seed/utils"
)

#LinkItemWithBom: {
	item4: {
		id:				utils.uuid & {_, #type: "item", #value: "5"}
		name:           "Wheels"
		description:    "Wheels"
		sku:            "WH-001"
		isFinalProduct: false
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: 			utils.uuid & {_, #type: "bom", #value: "2"}
	}
	item13: {
		id:				utils.uuid & {_, #type: "item", #value: "14"}
		name:           "7-speed Advance Mountain bike"
		description:    "7-speed Advance Mountain bike"
		sku:            "7-speed-001"
		isFinalProduct: true
		inventoryType:  "INVENTORY"
		uomId:          utils.uuid & {_, #type: "uom", #value: "1"}
		bomId: 			utils.uuid & {_, #type: "bom", #value: "1"}
	}

}


LinkItemWithBom: {
	items: [
		for k, v in #LinkItemWithBom {
			v
		},
	]
	query: """
		mutation ($input: [ItemCreateInput]) {
			bulkUpsertItems(input: $input)
	}"""
}
