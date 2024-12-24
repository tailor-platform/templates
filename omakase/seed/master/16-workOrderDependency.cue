package master

import (
	"tailor.build/template/seed/utils"
)

#WorkOrderDependency: {
	// Manufacturing Order Work Order Dependencies for Honda Motorcycle C125A 2AC
	WorkOrderDependency0: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "0"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "2"} // Electrical Systems Installation
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "0"} // Engine Assembly
	}
	WorkOrderDependency1: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "1"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "2"} // Electrical Systems Installation
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "1"} // Frame Assembly
	}
	WorkOrderDependency2: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "2"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "3"} // Casting Motorcycle Components
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "2"} // Electrical Systems Installation
	}
	WorkOrderDependency3: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "3"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "4"} // Painting Components
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "3"} // Casting Motorcycle Components
	}
	WorkOrderDependency4: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "4"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "5"} // Final Assembly
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "4"} // Painting Components
	}
	WorkOrderDependency5: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "5"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "6"} // Quality Control
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "5"} // Final Assembly
	}
	WorkOrderDependency6: {
		id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "6"}
		workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "7"} // Packaging
		dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "6"} // Quality Control
	}
	// WorkOrderDependency7: {
	// 	id: utils.uuid & {_, #type: "WorkOrderDependency", #value: "7"}
	// 	workOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "8"} // Engine Testing (Optional)
	// 	dependsOnWorkOrderId: utils.uuid & {_, #type: "WorkOrder", #value: "5"} // Final Assembly
	// }
}

WorkOrderDependency: {
	items: [
		for k, v in #WorkOrderDependency {
			v
		},
	]
}
