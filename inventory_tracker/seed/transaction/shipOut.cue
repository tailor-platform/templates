package transaction

import (
	"tailor.build/template/seed/utils"
)

#ShipOuts: {
	ShipOut1: {
		id: utils.uuid & {_, #type: "shipOut", #value: "1"}
		quantity:    5
		shipOutDate: "2023-11-11"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "1"}
	}
	ShipOut2: {
		id: utils.uuid & {_, #type: "shipOut", #value: "2"}
		quantity:    10
		shipOutDate: "2023-11-11"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "2"}
	}
	ShipOut3: {
		id: utils.uuid & {_, #type: "shipOut", #value: "3"}
		quantity:    2
		shipOutDate: "2023-11-12"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "3"}
	}
	ShipOut4: {
		id: utils.uuid & {_, #type: "shipOut", #value: "4"}
		quantity:    5
		shipOutDate: "2023-11-13"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "4"}
	}
	ShipOut5: {
		id: utils.uuid & {_, #type: "shipOut", #value: "5"}
		quantity:    1
		shipOutDate: "2023-11-14"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "5"}
	}
	ShipOut6: {
		id: utils.uuid & {_, #type: "shipOut", #value: "6"}
		quantity:    1
		shipOutDate: "2023-11-15"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "6"}
	}
	ShipOut7: {
		id: utils.uuid & {_, #type: "shipOut", #value: "7"}
		quantity:    10
		shipOutDate: "2023-11-16"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "7"}
	}
	ShipOut8: {
		id: utils.uuid & {_, #type: "shipOut", #value: "8"}
		quantity:    3
		shipOutDate: "2023-11-17"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "8"}
	}
	ShipOut9: {
		id: utils.uuid & {_, #type: "shipOut", #value: "9"}
		quantity:    3
		shipOutDate: "2023-11-18"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "9"}
	}
	ShipOut10: {
		id: utils.uuid & {_, #type: "shipOut", #value: "10"}
		quantity:    5
		shipOutDate: "2023-11-19"
		salesOrderID: utils.uuid & {_, #type: "salesOrder", #value: "10"}
	}
}

ShipOut: {
	items: [
		for k, v in #ShipOuts {
			v
		},
	]
}
