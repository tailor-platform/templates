package master

import (
	"tailor.build/template/seed/utils"
)

#Products: {
    Product1: {
        id: utils.uuid & {_, #type: "product", #value: "1"},
        code: 3001,
        name: "Organic Cotton T-Shirt",
        description: "Soft, breathable, and made from 100% organic cotton",
        price: 25,
        uom: "piece",
        sellingStartDate: "2023-11-01"
    },
    Product2: {
        id: utils.uuid & {_, #type: "product", #value: "2"},
        code: 3002,
        name: "Eco-Friendly Denim Jeans",
        description: "Stylish, durable jeans made from sustainably sourced denim",
        price: 75,
        uom: "pair",
        sellingStartDate: "2023-11-02"
    },
    Product3: {
        id: utils.uuid & {_, #type: "product", #value: "3"},
        code: 3003,
        name: "Bamboo Fiber Socks",
        description: "Comfortable, antibacterial socks made from bamboo fibers",
        price: 15,
        uom: "pair",
        sellingStartDate: "2023-11-03"
    },
    Product4: {
        id: utils.uuid & {_, #type: "product", #value: "4"},
        code: 3004,
        name: "Recycled Polyester Jacket",
        description: "Warm, lightweight jacket made from recycled polyester",
        price: 120,
        uom: "piece",
        sellingStartDate: "2023-11-04"
    },
    Product5: {
        id: utils.uuid & {_, #type: "product", #value: "5"},
        code: 3005,
        name: "Silk Scarf",
        description: "Luxurious, handcrafted scarf made from pure silk",
        price: 50,
        uom: "piece",
        sellingStartDate: "2023-11-05"
    }
}

Product: {
   items: [
		for k, v in #Products {
			v
		},
	],
}
