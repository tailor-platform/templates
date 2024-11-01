package master

import (
	"tailor.build/template/seed/utils"
)

#ManufacturingOrder: {
	manufacturingOrder0: {
		id: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		name: "Honda Motorcycle C125A 2AC"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "154"}
		componentsStatus: "Ready"
		status:"Draft"
		quantity: 1
	}
}

ManufacturingOrder: {
	items: [
		for k, v in #ManufacturingOrder {
			v
		},
	]
}
