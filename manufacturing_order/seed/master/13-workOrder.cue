package master

import (
	"tailor.build/template/seed/utils"
)

#WorkOrder: {
	workOrder0: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "1"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "1"}
		expectedDuration: 120
		order:1
	}
	workOrder1: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "2"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "2"}
		expectedDuration: 60
		order:1
	}
	workOrder2: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "3"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "3"}
		expectedDuration: 90
		order:2
	}
	workOrder3: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "4"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "4"}
		expectedDuration: 10
		order:3
	}
	workOrder4: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "5"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "5"}
		expectedDuration: 60
		order:4
	}
}

WorkOrder: {
	items: [
		for k, v in #WorkOrder {
			v
		},
	]
}
