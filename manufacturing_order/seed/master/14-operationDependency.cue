package master

import (
	"tailor.build/template/seed/utils"
)

#OperationDependency: {
	OperationDependency0: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "1"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "3"}
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "1"}
	}
	OperationDependency1: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "2"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "3"}
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "2"}
	}
	OperationDependency2: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "3"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "4"}
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "3"}
	}
	OperationDependency3: {
		id: utils.uuid & {_, #type: "OperationDependency", #value: "4"}
		operationId: utils.uuid & {_, #type: "Operation", #value: "5"}
		dependsOnOperationId: utils.uuid & {_, #type: "Operation", #value: "4"}
	}
}

OperationDependency: {
	items: [
		for k, v in #OperationDependency {
			v
		},
	]
}
