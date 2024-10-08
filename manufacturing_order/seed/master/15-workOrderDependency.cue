package master

import (
	"tailor.build/template/seed/utils"
)

#WorkOrderDependency: {
	WorkOrderDependency0: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "1"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "3"}
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "1"}
	}
	WorkOrderDependency1: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "2"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "3"}
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "2"}
	}
	WorkOrderDependency2: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "3"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "4"}
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "3"}
	}
	WorkOrderDependency3: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "4"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "5"}
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "4"}
	}
}

WorkOrderDependency: {
	items: [
		for k, v in #WorkOrderDependency {
			v
		},
	]
}
