package master

import (
	"tailor.build/template/seed/utils"
)

// #WorkOrderTransition defines the seed data for WorkOrderTransition entities
#WorkOrderTransition: {
	workOrderTransition0: {
		id: utils.uuid & {_, #type: "workOrdertransition", #value: "1"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "0"}
		fromStatus: "Draft"
		toStatus: "In_Progress"
		timeInStatus: 30 // Time in minutes
	}
}

// WorkOrderTransition aggregates all seed entries into a slice
WorkOrderTransition: {
	items: [
		for k, v in #WorkOrderTransition {
			v
		},
	]
}
