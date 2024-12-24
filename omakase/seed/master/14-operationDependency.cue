package master

import (
	"tailor.build/template/seed/utils"
)

#OperationDependency: {
	// Manufacturing Order Operation Dependencies for Honda Motorcycle C125A 2AC
	OperationDependency0: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "3"} // Electrical Systems Installation
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "1"} // Engine Assembly
	}
	OperationDependency1: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "2"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "3"} // Electrical Systems Installation
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "2"} // Frame Assembly
	}
	OperationDependency2: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "3"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "4"} // Casting Motorcycle Components
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "3"} // Electrical Systems Installation
	}
	OperationDependency3: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "4"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "5"} // Painting Components
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "4"} // Casting Motorcycle Components
	}
	OperationDependency4: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "5"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "6"} // Final Assembly
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "5"} // Painting Components
	}
	OperationDependency5: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "6"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "7"} // Quality Control
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "6"} // Final Assembly
	}
	OperationDependency6: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "7"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "8"} // Packaging
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "7"} // Quality Control
	}
	// OperationDependency7: {
	// 	id: utils.uuid & {_, #type: "OperationDependency", #value: "8"}
	// 	operationId: utils.uuid & {_, #type: "Operation", #value: "9"} // Engine Testing (Optional)
	// 	dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "6"} // Final Assembly
	// }
}

OperationDependency: {
	items: [
		for k, v in #OperationDependency {
			v
		},
	]
}
