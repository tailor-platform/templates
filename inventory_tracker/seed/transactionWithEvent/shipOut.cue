package transactionWithEvent

import (
	"tailor.build/template/seed/utils"
)

#ShipOuts: {
	ShipOut101: {
		quantity:    5
		shipOutDate: "2023-11-11"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "101"}
	}
}

ShipOutWithEvent: {
	items: [
		for k, v in #ShipOuts {
			v
		},
	]
	query: """
		    mutation ($input: createShipOutWithEventInput!) {
		        shipOut101: createShipOutWithEvent(input: $input)
		    }"""
}
