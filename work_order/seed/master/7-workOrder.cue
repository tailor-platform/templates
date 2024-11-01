package master

import (
	"tailor.build/template/seed/utils"
)

#WorkOrder: {
	// Manufacturing Order Line Items for Honda Motorcycle C125A 2AC
	workOrder0: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "1"}
		status: "Waiting_for_components"
		operationId: utils.uuid & {_, #type: "Operation", #value: "1"} // Engine Assembly
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "1"} // Engine Assembly Center
		expectedDuration: 180 // Duration in minutes
		realDuration:     140
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-01"
		endDate:          "2023-10-02"
	}
	workOrder1: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "2"}
		status: "Waiting_for_components"
		operationId: utils.uuid & {_, #type: "Operation", #value: "2"} // Frame Assembly
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "2"} // Frame Assembly Center
		expectedDuration: 150
		realDuration:     160
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-03"
		endDate:          "2023-10-04"
	}
	workOrder2: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "3"}
		status: "Blocked"
		operationId: utils.uuid & {_, #type: "Operation", #value: "3"} // Electrical Systems Installation
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "3"} // Electrical Systems Center
		expectedDuration: 90
		realDuration:     100
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-05"
		endDate:          "2023-10-06"
	}
	workOrder3: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "4"}
		status: "Blocked"
		operationId: utils.uuid & {_, #type: "Operation", #value: "4"} // Casting Motorcycle Components
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "4"} // Casting Center
		expectedDuration: 120
		realDuration:     115
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-07"
		endDate:          "2023-10-08"
	}
	workOrder4: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "5"}
		status: "Blocked"
		operationId: utils.uuid & {_, #type: "Operation", #value: "5"} // Painting Components
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "5"} // Painting Center
		expectedDuration: 100
		realDuration:     95
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-09"
		endDate:          "2023-10-10"
	}
	workOrder5: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "6"}
		status: "Blocked"
		operationId: utils.uuid & {_, #type: "Operation", #value: "6"} // Final Assembly
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "6"} // Final Assembly Center
		expectedDuration: 200
		realDuration:     210
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-11"
		endDate:          "2023-10-12"
	}
	workOrder6: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "7"}
		status: "Blocked"
		operationId: utils.uuid & {_, #type: "Operation", #value: "7"} // Quality Control
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "7"} // Quality Control Center
		expectedDuration: 30
		realDuration:     35
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-13"
		endDate:          "2023-10-14"
	}
	workOrder7: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "8"}
		status: "Blocked"
		operationId: utils.uuid & {_, #type: "Operation", #value: "8"} // Packaging
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "8"} // Packaging Center
		expectedDuration: 80
		realDuration:     75
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-15"
		endDate:          "2023-10-16"
	}
	// workOrder8: {
	// 	id: utils.uuid & {_, #type: "WorkOrder", #value: "9"}
	// 	status: "Optional"
	// 	operationId: utils.uuid & {_, #type: "Operation", #value: "9"} // Engine Testing (Optional)
	// 	workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "9"} // Engine Testing Center
	// 	expectedDuration: 60
	// 	realDuration:     0
	// 	isBlocked:        false
	// 	isDeleted:        false
	// 	startDate:        ""
	// 	endDate:          ""
	// }
}

WorkOrder: {
	items: [
		for k, v in #WorkOrder {
			v
		},
	]
}
