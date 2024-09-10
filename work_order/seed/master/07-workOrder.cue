package master

import (
	"tailor.build/template/seed/utils"
)

#WorkOrder: {
	workOrder0: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "1"}
		status: "Waiting_for_components"
		operationId: utils.uuid & {_, #type: "Operation", #value: "1"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "4"}
		expectedDuration: 120
		realDuration:     140
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-01"
		endDate:          "2023-10-02"
	}
	workOrder1: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "2"}
		status: "In_Progress"
		operationId: utils.uuid & {_, #type: "Operation", #value: "2"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "4"}
		expectedDuration: 60
		realDuration:     50
		isBlocked:        false
		isDeleted:        false
		startDate:        "2023-10-03"
		endDate:          "2023-10-03"
	}
	workOrder2: {
		id: utils.uuid & {_, #type: "WorkOrder", #value: "3"}
		status: "Finished"
		operationId: utils.uuid & {_, #type: "Operation", #value: "3"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "1"}
		expectedDuration: 90
		realDuration:     0 // assuming 0 for missing value
		isBlocked:        false
		isDeleted:        true
		startDate:        "2023-10-04"
		endDate:          "2023-10-04"
	}
}

WorkOrder: {
	items: [
		for k, v in #WorkOrder {
			v
		},
	]
}
