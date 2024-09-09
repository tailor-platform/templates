package master

import (
	"tailor.build/template/seed/utils"
)

#WOTimeTracking: {
	woTimeTracking0: {
		id: utils.uuid & {_, #type: "WOTimeTracking", #value: "1"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "1"}
		employeeId: utils.uuid & {_, #type: "Employee", #value: "1"}
		duration:  120
		startDate: "2024-08-05T06:55:41Z"
		endDate:   "2024-08-05T06:55:41Z"
	}
}

WOTimeTracking: {
	items: [
		for k, v in #WOTimeTracking {
			v
		},
	]
}
