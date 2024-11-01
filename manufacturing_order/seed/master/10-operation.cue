package master

import (
	"tailor.build/template/seed/utils"
)

#Operation: {
	// 1. Engine Assembly
	operation0: {
		id: utils.uuid & {_, #type: "Operation", #value: "1"}
		name: "Engine Assembly"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"} // Updated to final product BOM
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "1"} // Engine Assembly Center
		duration:    180 // Duration in minutes
		description: "Assembling the motorcycle engine from components."
		documentUrl: "http://example.com/docs/engine-assembly"
		isActive:    true
		order:1
	}
	
	// 2. Frame Assembly
	operation1: {
		id: utils.uuid & {_, #type: "Operation", #value: "2"}
		name: "Frame Assembly"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"} // Final product BOM
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "2"} // Frame Assembly Center
		duration:    150
		description: "Assembling the motorcycle frame and structural components."
		documentUrl: "http://example.com/docs/frame-assembly"
		isActive:    true
		order:2
	}
	
	// 3. Electrical Systems Installation
	operation2: {
		id: utils.uuid & {_, #type: "Operation", #value: "3"}
		name: "Electrical Systems Installation"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "3"} // Electrical Systems Center
		duration:    90
		description: "Installing electrical systems, wiring, and electronics."
		documentUrl: "http://example.com/docs/electrical-installation"
		isActive:    true
		order:3
	}
	
	// 4. Casting Motorcycle Components
	operation3: {
		id: utils.uuid & {_, #type: "Operation", #value: "4"}
		name: "Casting Motorcycle Components"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "4"} // Casting Center
		duration:    120
		description: "Casting metal components specific to motorcycle production."
		documentUrl: "http://example.com/docs/casting"
		isActive:    true
		order:4
	}
	
	// 5. Painting Components
	operation4: {
		id: utils.uuid & {_, #type: "Operation", #value: "5"}
		name: "Painting Components"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "5"} // Painting Center
		duration:    100
		description: "Painting motorcycle frames, engines, and other components."
		documentUrl: "http://example.com/docs/painting"
		isActive:    true
		order:5
	}
	
	// 6. Final Assembly
	operation5: {
		id: utils.uuid & {_, #type: "Operation", #value: "6"}
		name: "Final Assembly"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "6"} // Final Assembly Center
		duration:    200
		description: "Integrating all major components into the finished motorcycle."
		documentUrl: "http://example.com/docs/final-assembly"
		isActive:    true
		order:6
	}
	
	// 7. Quality Control
	operation6: {
		id: utils.uuid & {_, #type: "Operation", #value: "7"}
		name: "Quality Control"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "7"} // Quality Control Center
		duration:    30
		description: "Conducting quality assurance and testing of completed motorcycles."
		documentUrl: "http://example.com/docs/quality-control"
		isActive:    true
		order:7
	}
	
	// 8. Packaging
	operation7: {
		id: utils.uuid & {_, #type: "Operation", #value: "8"}
		name: "Packaging"
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "8"} // Packaging Center
		duration:    80
		description: "Packaging completed motorcycles for shipping."
		documentUrl: "http://example.com/docs/packaging"
		isActive:    true
		order:8
	}
	
	// // Optional: Engine Testing
	// operation8: {
	// 	id: utils.uuid & {_, #type: "Operation", #value: "9"}
	// 	name: "Engine Testing"
	// 	bomId: utils.uuid & {_, #type: "bom", #value: "25"}
	// 	workCenterId: utils.uuid & {_, #type: "WorkCenter", #value: "9"} // Assuming WorkCenter 9 is added for Engine Testing
	// 	duration:    60
	// 	description: "Testing engine performance and reliability."
	// 	documentUrl: "http://example.com/docs/engine-testing"
	// 	isActive:    true
	// 	order:9
	// }
}

Operation: {
	items: [
		for k, v in #Operation {
			v
		},
	]
}
