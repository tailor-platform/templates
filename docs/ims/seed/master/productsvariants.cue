package master

import (
	"tailor.build/template/seed/utils"
)

#ProductVariants: {
	productVariant1: {
		id: utils.uuid & {_, #type: "productvariant", #value: "1"}
		productID: utils.uuid & {_, #type: "product", #value: "1"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Always Happy Long Sleeve T-Shirt - Coral / SM"
		price:             29.99
		taxable:           true
		sku:               "XXG12320CORSM"
		inventoryType:     "INVENTORY"
	}
	productVariant2: {
		id: utils.uuid & {_, #type: "productvariant", #value: "2"}
		productID: utils.uuid & {_, #type: "product", #value: "1"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Always Happy Long Sleeve T-Shirt - Coral / L"
		price:             29.99
		taxable:           true
		sku:               "XXG12320CORSM"
		inventoryType:     "INVENTORY"
	}
	productVariant3: {
		id: utils.uuid & {_, #type: "productvariant", #value: "3"}
		productID: utils.uuid & {_, #type: "product", #value: "2"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Stylish Backpack - Black"
		price:             49.99
		taxable:           true
		sku:               "XXG12321BLK"
		inventoryType:     "INVENTORY"
	}
	productVariant4: {
		id: utils.uuid & {_, #type: "productvariant", #value: "4"}
		productID: utils.uuid & {_, #type: "product", #value: "2"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Stylish Backpack - Gray"
		price:             49.99

		taxable:       true
		sku:           "XXG12321GRY"
		inventoryType: "INVENTORY"
	}
	productVariant5: {
		id: utils.uuid & {_, #type: "productvariant", #value: "5"}
		productID: utils.uuid & {_, #type: "product", #value: "3"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Trendy Hoodie - Black / S"
		price:             39.99
		taxable:           true
		sku:               "XXG12322BLKS"
		inventoryType:     "INVENTORY"
	}
	productVariant6: {
		id: utils.uuid & {_, #type: "productvariant", #value: "6"}
		productID: utils.uuid & {_, #type: "product", #value: "3"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Trendy Hoodie - Black / M"
		price:             39.99
		taxable:           true
		sku:               "XXG12322BLKM"
		inventoryType:     "INVENTORY"
	}
	productVariant7: {
		id: utils.uuid & {_, #type: "productvariant", #value: "7"}
		productID: utils.uuid & {_, #type: "product", #value: "4"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Elegant Dress - Black / XS"
		price:             79.99
		taxable:           true
		sku:               "XXG12323BLKXS"
		inventoryType:     "INVENTORY"
	}
	productVariant8: {
		id: utils.uuid & {_, #type: "productvariant", #value: "8"}
		productID: utils.uuid & {_, #type: "product", #value: "4"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Elegant Dress - Black / S"
		price:             79.99
		taxable:           true
		sku:               "XXG12323BLKS"
		inventoryType:     "INVENTORY"
	}
	productVariant9: {
		id: utils.uuid & {_, #type: "productvariant", #value: "9"}
		productID: utils.uuid & {_, #type: "product", #value: "5"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Classic Jeans - Blue / 28"
		price:             59.99
		taxable:           true
		sku:               "XXG12324BLU28"
		inventoryType:     "INVENTORY"
	}
	productVariant10: {
		id: utils.uuid & {_, #type: "productvariant", #value: "10"}
		productID: utils.uuid & {_, #type: "product", #value: "5"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Classic Jeans - Blue / 30"
		price:             59.99
		taxable:           true
		sku:               "XXG12324BLU30"
		inventoryType:     "INVENTORY"
	}
	productVariant11: {
		id: utils.uuid & {_, #type: "productvariant", #value: "11"}
		productID: utils.uuid & {_, #type: "product", #value: "6"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Cozy Sweater - Gray / XS"
		price:             49.99
		taxable:           true
		sku:               "XXG12325GRYXS"
		inventoryType:     "INVENTORY"
	}
	productVariant12: {
		id: utils.uuid & {_, #type: "productvariant", #value: "12"}
		productID: utils.uuid & {_, #type: "product", #value: "6"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Cozy Sweater - Gray / S"
		price:             49.99
		taxable:           true
		sku:               "XXG12325GRYS"
		inventoryType:     "INVENTORY"
	}
	productVariant13: {
		id: utils.uuid & {_, #type: "productvariant", #value: "13"}
		productID: utils.uuid & {_, #type: "product", #value: "7"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Practical Shorts - Khaki / 32"
		price:             34.99
		taxable:           true
		sku:               "XXG12326KHK32"
		inventoryType:     "INVENTORY"
	}
	productVariant14: {
		id: utils.uuid & {_, #type: "productvariant", #value: "14"}
		productID: utils.uuid & {_, #type: "product", #value: "7"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Practical Shorts - Khaki / 34"
		price:             34.99
		taxable:           true
		sku:               "XXG12326KHK34"
		inventoryType:     "INVENTORY"
	}
	productVariant15: {
		id: utils.uuid & {_, #type: "productvariant", #value: "15"}
		productID: utils.uuid & {_, #type: "product", #value: "8"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Sporty Sneakers - White / 8"
		price:             69.99
		taxable:           true
		sku:               "XXG12327WHT8"
		inventoryType:     "INVENTORY"
	}
	productVariant16: {
		id: utils.uuid & {_, #type: "productvariant", #value: "16"}
		productID: utils.uuid & {_, #type: "product", #value: "8"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Sporty Sneakers - White / 9"
		price:             69.99
		taxable:           true
		sku:               "XXG12327WHT9"
		inventoryType:     "INVENTORY"
	}
	productVariant17: {
		id: utils.uuid & {_, #type: "productvariant", #value: "17"}
		productID: utils.uuid & {_, #type: "product", #value: "9"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Elegant Blouse - White / XS"
		price:             54.99
		taxable:           true
		sku:               "XXG12328WHTXS"
		inventoryType:     "INVENTORY"
	}
	productVariant18: {
		id: utils.uuid & {_, #type: "productvariant", #value: "18"}
		productID: utils.uuid & {_, #type: "product", #value: "9"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Elegant Blouse - White / S"
		price:             54.99
		taxable:           true
		sku:               "XXG12328WHTS"
		inventoryType:     "INVENTORY"
	}
	productVariant19: {
		id: utils.uuid & {_, #type: "productvariant", #value: "19"}
		productID: utils.uuid & {_, #type: "product", #value: "10"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Fashionable Sunglasses - Black"
		price:             29.99
		taxable:           true
		sku:               "XXG12329BLK"
		inventoryType:     "INVENTORY"
	}
	productVariant20: {
		id: utils.uuid & {_, #type: "productvariant", #value: "20"}
		productID: utils.uuid & {_, #type: "product", #value: "10"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Fashionable Sunglasses - Brown"
		price:             29.99
		taxable:           true
		sku:               "XXG12329BRN"
		inventoryType:     "INVENTORY"
	}
	productVariant21: {
		id: utils.uuid & {_, #type: "productvariant", #value: "21"}
		productID: utils.uuid & {_, #type: "product", #value: "11"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Cozy Pajamas - Pink / XS"
		price:             39.99
		taxable:           true
		sku:               "XXG12330PNKXS"
		inventoryType:     "INVENTORY"
	}
	productVariant22: {
		id: utils.uuid & {_, #type: "productvariant", #value: "22"}
		productID: utils.uuid & {_, #type: "product", #value: "11"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Cozy Pajamas - Pink / S"
		price:             39.99
		taxable:           true
		sku:               "XXG12330PNKS"
		inventoryType:     "INVENTORY"
	}
	productVariant23: {
		id: utils.uuid & {_, #type: "productvariant", #value: "23"}
		productID: utils.uuid & {_, #type: "product", #value: "12"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Timeless Watch - Silver"
		price:             99.99
		taxable:           true
		sku:               "XXG12331SIL"
		inventoryType:     "INVENTORY"
	}
	productVariant24: {
		id: utils.uuid & {_, #type: "productvariant", #value: "24"}
		productID: utils.uuid & {_, #type: "product", #value: "12"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Timeless Watch - Gold"
		price:             99.99
		taxable:           true
		sku:               "XXG12331GLD"
		inventoryType:     "INVENTORY"
	}
	productVariant25: {
		id: utils.uuid & {_, #type: "productvariant", #value: "25"}
		productID: utils.uuid & {_, #type: "product", #value: "13"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Supportive Sports Bra - Black / XS"
		price:             29.99
		taxable:           true
		sku:               "XXG12332BLKXS"
		inventoryType:     "INVENTORY"
	}
	productVariant26: {
		id: utils.uuid & {_, #type: "productvariant", #value: "26"}
		productID: utils.uuid & {_, #type: "product", #value: "13"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Supportive Sports Bra - Black / S"
		price:             29.99
		taxable:           true
		sku:               "XXG12332BLKS"
		inventoryType:     "INVENTORY"
	}
	productVariant27: {
		id: utils.uuid & {_, #type: "productvariant", #value: "27"}
		productID: utils.uuid & {_, #type: "product", #value: "14"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Functional Wallet - Brown"
		price:             49.99
		taxable:           true
		sku:               "XXG12333BRN"
		inventoryType:     "INVENTORY"
	}
	productVariant28: {
		id: utils.uuid & {_, #type: "productvariant", #value: "28"}
		productID: utils.uuid & {_, #type: "product", #value: "14"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Functional Wallet - Black"
		price:             49.99
		taxable:           true
		sku:               "XXG12333BLK"
		inventoryType:     "INVENTORY"
	}
	productVariant29: {
		id: utils.uuid & {_, #type: "productvariant", #value: "29"}
		productID: utils.uuid & {_, #type: "product", #value: "15"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Running Jacket - Black / S"
		price:             79.99
		taxable:           true
		sku:               "XXG12334BLKS"
		inventoryType:     "INVENTORY"
	}
	productVariant30: {
		id: utils.uuid & {_, #type: "productvariant", #value: "30"}
		productID: utils.uuid & {_, #type: "product", #value: "15"}
		availableForSale:  true
		inventoryQuantity: 0
		displayName:       "Running Jacket - Black / M"
		price:             79.99
		taxable:           true
		sku:               "XXG12334BLKM"
		inventoryType:     "INVENTORY"
	}

}

ProductVariant: {
	items: [
		for k, v in #ProductVariants {
			v
		},
	]
}
