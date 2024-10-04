package master

import (
	"tailor.build/template/seed/utils"
)

#ManufacturingOrder: {
	manufacturingOrder0: {
		id: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		name: "Mountain bike"
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "1"}
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
