package master

import (
	"tailor.build/template/seed/utils"
)

#Products: {
	Product1: {
		id: utils.uuid & {_, #type: "product", #value: "0001"}
		code:        "PROD0001"
		name:        "Samsung Galaxy S23 Ultra"
		description: ""
		price:       789.34
		uom:         "pcs"
	}
	Product2: {
		id: utils.uuid & {_, #type: "product", #value: "0002"}
		code:        "PROD0002"
		name:        "Sony PlayStation 5 SLIM Disc"
		description: ""
		price:       456.07
		uom:         "pcs"
	}
	Product3: {
		id: utils.uuid & {_, #type: "product", #value: "0003"}
		code:        "PROD0003"
		name:        "Apple 2022 10.9-inch iPad (Wi-Fi, 64GB)"
		description: ""
		price:       395.53
		uom:         "pcs"
	}
	Product4: {
		id: utils.uuid & {_, #type: "product", #value: "0004"}
		code:        "PROD0004"
		name:        "Apple iPhone 15 Pro (128 GB) - Blue Titanium"
		description: ""
		price:       1048
		uom:         "pcs"
	}
	Product5: {
		id: utils.uuid & {_, #type: "product", #value: "0005"}
		code:        "PROD0005"
		name:        "Apple iPhone 14 Plus (128 GB) - Starlight"
		description: ""
		price:       816
		uom:         "pcs"
	}
	Product6: {
		id: utils.uuid & {_, #type: "product", #value: "0006"}
		code:        "PROD0006"
		name:        "Samsung Galaxy A34 Dual SIM"
		description: ""
		price:       197.4
		uom:         "pcs"
	}
	Product7: {
		id: utils.uuid & {_, #type: "product", #value: "0007"}
		code:        "PROD0007"
		name:        "Apple 2021 iPad mini (8.3-inch, Wi-Fi, 64GB)"
		description: ""
		price:       517.06
		uom:         "pcs"
	}
	Product8: {
		id: utils.uuid & {_, #type: "product", #value: "0008"}
		code:        "PROD0008"
		name:        "Mac mini: Apple M1 chip with 8‑core CPU and 8‑core GPU, 512GB SSD"
		description: ""
		price:       653.2
		uom:         "pcs"
	}
	Product9: {
		id: utils.uuid & {_, #type: "product", #value: "0009"}
		code:        "PROD0009"
		name:        "Apple 2023 MacBook Pro (14-inch, Apple M3 chip"
		description: ""
		price:       1905.69
		uom:         "pcs"
	}
	Product10: {
		id: utils.uuid & {_, #type: "product", #value: "0010"}
		code:        "PROD0010"
		name:        "TCL 55 Inches Smart TV, 4K Ultra HD"
		description: ""
		price:       269.28
		uom:         "pcs"
	}
	Product11: {
		id: utils.uuid & {_, #type: "product", #value: "0011"}
		code:        "PROD0011"
		name:        "Sony Alpha 7CR ILCE-7CR Black | High Resolution Compact Full-frame Camera"
		description: ""
		price:       2586.48
		uom:         "pcs"
	}
}

Product: {
	items: [
		for k, v in #Products {
			v
		},
	]
}
