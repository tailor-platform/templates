package master

import (
	"tailor.build/template/seed/utils"
)

#WorkOrder: {
	// Manufacturing Order Line Items for Honda Motorcycle C125A 2AC
	workOrder0: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "0"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "1"} // Engine Assembly
		expectedDuration: 180 // Duration in minutes
		order: 1
	}
	workOrder1: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "1"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "2"} // Frame Assembly
		expectedDuration: 150
		order: 2
	}
	workOrder2: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "2"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "3"} // Electrical Systems Installation
		expectedDuration: 90
		order: 3
	}
	workOrder3: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "3"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "4"} // Casting Motorcycle Components
		expectedDuration: 120
		order: 4
	}
	workOrder4: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "4"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "5"} // Painting Components
		expectedDuration: 100
		order: 5
	}
	workOrder5: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "5"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "6"} // Final Assembly
		expectedDuration: 200
		order: 6
	}
	workOrder6: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "6"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "7"} // Quality Control
		expectedDuration: 30
		order: 7
	}
	workOrder7: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "7"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "8"} // Packaging
		expectedDuration: 80
		order: 8
	}
	// workOrder8: {
	// 	id: utils.uuid & {_, #type: "WorkOrder", #value: "8"}
	// 	moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
	// 	operationId: utils.uuid & {_, #type: "Operation", #value: "9"} // Engine Testing (Optional)
	// 	expectedDuration: 60
	// 	order: 9
	// }
}

WorkOrder: {
	items: [
		for k, v in #WorkOrder {
			v
		},
	]
}
