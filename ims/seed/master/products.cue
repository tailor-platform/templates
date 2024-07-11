package master

import (
	"tailor.build/template/seed/utils"
)

#Products: {
	product1: {
		id: utils.uuid & {_, #type: "product", #value: "1"}
		active: null
		description: "This is a high-quality long sleeve t-shirt made from soft and comfortable fabric. It features a unique design with the phrase 'Always Happy' printed on the front. Perfect for casual wear and expressing a positive attitude."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "1"}
		handle: "always-happy-ls"
		title: "Always Happy Long Sleeve T-Shirt"
	}
	product2: {
		id: utils.uuid & {_, #type: "product", #value: "2"}
		active: null
		description: "This is a stylish and versatile backpack made from durable materials. It features multiple compartments and pockets for easy organization. Perfect for everyday use and carrying essentials."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "2"}
		handle: "stylish-backpack"
		title: "Stylish Backpack"
	},
	product3: {
		id: utils.uuid & {_, #type: "product", #value: "3"}
		active: null
		description: "This is a trendy and comfortable hoodie made from premium cotton. It features a modern design with a hood and front pocket. Perfect for staying cozy and stylish during colder seasons."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "3"}
		handle: "trendy-hoodie"
		title: "Trendy Hoodie"
	}
	product4: {
		id: utils.uuid & {_, #type: "product", #value: "4"}
		active: null
		description: "This is a classic and elegant dress made from high-quality fabric. It features a flattering silhouette and a timeless design. Perfect for special occasions and formal events."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "4"}
		handle: "elegant-dress"
		title: "Elegant Dress"
	}
	product5: {
		id: utils.uuid & {_, #type: "product", #value: "5"}
		active: null
		description: "This is a comfortable and stylish pair of jeans made from high-quality denim. It features a slim fit and classic design. Perfect for casual and everyday wear."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "5"}
		handle: "classic-jeans"
		title: "Classic Jeans"
	},
	product6: {
		id: utils.uuid & {_, #type: "product", #value: "6"}
		active: null
		description: "This is a cozy and warm sweater made from soft wool. It features a cable knit pattern and a relaxed fit. Perfect for layering and staying comfortable in colder weather."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "6"}
		handle: "cozy-sweater"
		title: "Cozy Sweater"
	},
	product7: {
		id: utils.uuid & {_, #type: "product", #value: "7"}
		active: null
		description: "This is a versatile and practical pair of shorts made from lightweight fabric. It features an elastic waistband and multiple pockets. Perfect for outdoor activities and casual summer days."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "7"}
		handle: "practical-shorts"
		title: "Practical Shorts"
	},
	product8: {
		id: utils.uuid & {_, #type: "product", #value: "8"}
		active: null
		description: "This is a sporty and comfortable pair of sneakers made from breathable materials. It features cushioned soles and a stylish design. Perfect for running and everyday activities."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "8"}
		handle: "sporty-sneakers"
		title: "Sporty Sneakers"
	},
	product9: {
		id: utils.uuid & {_, #type: "product", #value: "9"}
		active: null
		description: "This is a chic and elegant blouse made from silky fabric. It features a flowy silhouette and delicate details. Perfect for dressing up and adding a touch of sophistication to any outfit."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "9"}
		handle: "elegant-blouse"
		title: "Elegant Blouse"
	},
	product10: {
		id: utils.uuid & {_, #type: "product", #value: "10"}
		active: null
		description: "This is a trendy and fashionable pair of sunglasses made from durable materials. It features UV protection and a stylish frame. Perfect for adding a cool and stylish touch to any look."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "10"}
		handle: "fashionable-sunglasses"
		title: "Fashionable Sunglasses"
	},
	product11: {
		id: utils.uuid & {_, #type: "product", #value: "11"}
		active: null
		description: "This is a cozy and soft pair of pajamas made from comfortable cotton. It features a cute and playful print. Perfect for lounging and getting a good night's sleep."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "11"}
		handle: "cozy-pajamas"
		title: "Cozy Pajamas"
	},
	product12: {
		id: utils.uuid & {_, #type: "product", #value: "12"}
		active: null
		description: "This is a classic and timeless watch made from high-quality materials. It features a sleek design and reliable movement. Perfect for adding a touch of elegance to any outfit."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "12"}
		handle: "timeless-watch"
		title: "Timeless Watch"
	},
	product13: {
		id: utils.uuid & {_, #type: "product", #value: "13"}
		active: null
		description: "This is a comfortable and supportive sports bra made from moisture-wicking fabric. It features adjustable straps and a secure fit. Perfect for workouts and active lifestyles."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "13"}
		handle: "supportive-sports-bra"
		title: "Supportive Sports Bra"
	},
	product14: {
		id: utils.uuid & {_, #type: "product", #value: "14"}
		active: null
		description: "This is a stylish and functional wallet made from genuine leather. It features multiple card slots and a zippered coin pocket. Perfect for keeping your essentials organized and secure."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "14"}
		handle: "functional-wallet"
		title: "Functional Wallet"
	},
	product15: {
		id: utils.uuid & {_, #type: "product", #value: "15"}
		active: null
		description: "This is a lightweight and breathable running jacket made from water-resistant fabric. It features reflective details and a zippered pocket. Perfect for outdoor activities and staying visible in low-light conditions."
		featuredImageID: utils.uuid & {_, #type: "image", #value: "15"}
		handle: "running-jacket"
		title: "Running Jacket"
	}

}

Product: {
	items: [
		for k, v in #Products {
			v
		},
	]
}



