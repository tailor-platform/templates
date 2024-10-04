package master

import (
	"tailor.build/template/seed/utils"
)

#Operation: {
	operation0: {
		id: utils.uuid & {_, #type: "Operation", #value: "1"}
		name: "Frame Manufacturing"
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "4"}
		duration:    120
		description: "Operation for assembling products"
		documentUrl: "http://example.com/doc-1"
		isActive:    true
		order:1
	}
	operation1: {
		id: utils.uuid & {_, #type: "Operation", #value: "2"}
		name: " Wheel Building"
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "4"}
		duration:    60
		description: "Operation for making wheel"
		documentUrl: "http://example.com/doc-2"
		isActive:    true
		order:1
	}
	operation2: {
		id: utils.uuid & {_, #type: "Operation", #value: "3"}
		name: "Assembly"
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "1"}
		duration:    90
		description: "Assenbly of all parts"
		documentUrl: "http://example.com/doc-3"
		isActive:    true
		order:2
	}
	operation3: {
		id: utils.uuid & {_, #type: "Operation", #value: "4"}
		name: "Quality Check"
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "3"}
		duration:    10
		description: "Quality check of the product"
		documentUrl: "http://example.com/doc-4"
		isActive:    true
		order:3
	}
	operation4: {
		id: utils.uuid & {_, #type: "Operation", #value: "5"}
		name: "Packaging"
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "5"}
		duration:    60
		description: "Packing of the product"
		documentUrl: "http://example.com/doc-5"
		isActive:    true
		order:4
	}
}

Operation: {
	items: [
		for k, v in #Operation {
			v
		},
	]
}
