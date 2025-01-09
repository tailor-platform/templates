package master

import (
	"tailor.build/template/seed/utils"
)

// Same structure, now referencing the hat BOM (#25) 
// and realistic operation descriptions.

#Operation: {
	operation0: {
		id: utils.uuid & {_, #type: "Operation", #value: "1"}
		name: "Base Assembly"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "1"}
		duration:    180
		description: "Assembling the main crown of the Ace Iconic Performance Hat."
		documentUrl: "http://example.com/docs/hat-assembly"
		isActive:    true
		order:1
	}
	
	operation1: {
		id: utils.uuid & {_, #type: "Operation", #value: "2"}
		name: "Frame Assembly"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "2"}
		duration:    150
		description: "Joining the structural panels of the hat."
		documentUrl: "http://example.com/docs/hat-frame-assembly"
		isActive:    true
		order:2
	}
	
	operation2: {
		id: utils.uuid & {_, #type: "Operation", #value: "3"}
		name: "Patches Installation"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "3"}
		duration:    90
		description: "Attaching brand labels, embroidered patches, or similar attachments."
		documentUrl: "http://example.com/docs/hat-electrical-installation"
		isActive:    true
		order:3
	}
	
	operation3: {
		id: utils.uuid & {_, #type: "Operation", #value: "4"}
		name: "Casting Components"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "4"}
		duration:    120
		description: "Molding or shaping the visor and any special forms for the hat."
		documentUrl: "http://example.com/docs/hat-casting"
		isActive:    true
		order:4
	}
	
	operation4: {
		id: utils.uuid & {_, #type: "Operation", #value: "5"}
		name: "Painting Components"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "5"}
		duration:    100
		description: "Painting or dyeing the hat's fabric panels."
		documentUrl: "http://example.com/docs/hat-painting"
		isActive:    true
		order:5
	}
	
	operation5: {
		id: utils.uuid & {_, #type: "Operation", #value: "6"}
		name: "Final Assembly"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "6"}
		duration:    200
		description: "Completing the assembly of all sub-components into final hat."
		documentUrl: "http://example.com/docs/hat-final-assembly"
		isActive:    true
		order:6
	}
	
	operation6: {
		id: utils.uuid & {_, #type: "Operation", #value: "7"}
		name: "Quality Control"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "7"}
		duration:    30
		description: "Performing quality checks on the finished hat."
		documentUrl: "http://example.com/docs/hat-quality-control"
		isActive:    true
		order:7
	}
	
	operation7: {
		id: utils.uuid & {_, #type: "Operation", #value: "8"}
		name: "Packaging"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "8"}
		duration:    80
		description: "Packaging completed Ace Iconic Performance Hat for shipment."
		documentUrl: "http://example.com/docs/hat-packaging"
		isActive:    true
		order:8
	}
}

Operation: {
	items: [
		for k, v in #Operation {
			v
		},
	]
}
