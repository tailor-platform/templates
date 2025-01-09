package master

import (
	"tailor.build/template/seed/utils"
)

#ManufacturingOrder: {
	manufacturingOrder0: {
		id: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		name: "Ace Iconic Performance Hat"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "154"}
		componentsStatus: "Ready"
		status:"Completed"
		quantity: 1
	},
	manufacturingOrder1: {
		id: utils.uuid & {_, #type: "ManufacturingOrder", #value: "2"}
		name: "Ace Iconic Performance Hat"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "154"}
		componentsStatus: "Ready"
		status:"Canceled"
		quantity: 1
		moBatchId: utils.uuid & {_, #type: "Mobatch", #value: "1"}
	}
}

ManufacturingOrder: {
	items: [
		for k, v in #ManufacturingOrder {
			v
		},
	]
}
