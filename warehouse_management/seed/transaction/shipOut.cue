package transaction

import (
	"tailor.build/template/seed/utils"
)

#seeds: {
	ShipOut1: {
		id: utils.Uuid & {_, #type: "ShipOut", #value: "1"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "1"}
		shipOutDate: "2023-07-05"
	}
	ShipOut2: {
		id: utils.Uuid & {_, #type: "ShipOut", #value: "2"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "2"}
		shipOutDate: "2023-07-20"
	}
	ShipOut3: {
		id: utils.Uuid & {_, #type: "ShipOut", #value: "3"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "3"}
		shipOutDate: "2023-08-05"
	}
	ShipOut4: {
		id: utils.Uuid & {_, #type: "ShipOut", #value: "4"}
		salesOrderID: utils.Uuid & {_, #type: "SalesOrder", #value: "4"}
		shipOutDate: "2023-08-20"
	}
}

ShipOut: {
	items:
	[
		for k, v in #seeds {
			v
		},
	]
}
