package master

import (
	"tailor.build/template/seed/utils"
)

#WorkCenter: {
	// 1. Engine Assembly Center
	workCenter0: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "1"}
		name:        "Engine Assembly Center"
		description: "Center dedicated to assembling motorcycle engines"
		code:        "WCE-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.85
		parallelProcessingLimit:  2
		setupTime:       30 // Increased for complex engine assembly
		cleanupTime:     30
		hourlyProcessingCost:     150 // Higher due to specialized tasks
		costPerEmployee: 30
		isActive:        true
	}
	
	// 2. Frame Assembly Center
	workCenter1: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "2"}
		name:        "Frame Assembly Center"
		description: "Center for assembling motorcycle frames and structural components"
		code:        "WCF-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.9
		parallelProcessingLimit:  3
		setupTime:       20
		cleanupTime:     15
		hourlyProcessingCost:     120
		costPerEmployee: 25
		isActive:        true
	}
	
	// 3. Electrical Systems Center
	workCenter2: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "3"}
		name:        "Electrical Systems Center"
		description: "Center for installing electrical systems, wiring, and electronics"
		code:        "WCELEC-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.95
		parallelProcessingLimit:  4
		setupTime:       10
		cleanupTime:     10
		hourlyProcessingCost:     90
		costPerEmployee: 20
		isActive:        true
	}
	
	// 4. Casting Center
	workCenter3: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "4"}
		name:        "Casting Center"
		description: "Center for casting metal components specific to motorcycles"
		code:        "WCCC-002"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  1.0
		parallelProcessingLimit:  2
		setupTime:       25 // Increased for motorcycle-specific components
		cleanupTime:     25
		hourlyProcessingCost:     130
		costPerEmployee: 50
		isActive:        true
	}
	
	// 5. Painting Center
	workCenter4: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "5"}
		name:        "Painting Center"
		description: "Center for painting motorcycle frames, engines, and other components"
		code:        "WCP-002" // Updated code to differentiate from bicycle packing
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  1.0
		parallelProcessingLimit:  3
		setupTime:       20 // Adjusted for larger components
		cleanupTime:     20
		hourlyProcessingCost:     110
		costPerEmployee: 35
		isActive:        true
	}
	
	// 6. Final Assembly Center
	workCenter5: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "6"}
		name:        "Final Assembly Center"
		description: "Center for final assembly of all motorcycle components into finished units"
		code:        "WCF-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.88
		parallelProcessingLimit:  2
		setupTime:       25
		cleanupTime:     25
		hourlyProcessingCost:     140
		costPerEmployee: 30
		isActive:        true
	}
	
	// 7. Quality Control Center
	workCenter6: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "7"}
		name:        "Quality Control Center"
		description: "Center for quality assurance and testing of completed motorcycles"
		code:        "WCQC-002"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.95
		parallelProcessingLimit:  4
		setupTime:       0
		cleanupTime:     0
		hourlyProcessingCost:     20
		costPerEmployee: 30
		isActive:        true
	}
	
	// 8. Packaging Center
	workCenter7: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "8"}
		name:        "Packaging Center"
		description: "Center for packaging completed motorcycles for shipping"
		code:        "WCP-002" // Updated code
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.9
		parallelProcessingLimit:  3
		setupTime:       15
		cleanupTime:     10
		hourlyProcessingCost:     100
		costPerEmployee: 25
		isActive:        true
	}
	
	// workCenter8: {
	// 	id: utils.uuid & {_, #type: "WorkCenter", #value: "9"}
	// 	name:        "Engine Testing Center"
	// 	description: "Center for testing engine performance and reliability"
	// 	code:        "WCET-001"
	// 	workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
	// 	timeEfficiency:  0.9
	// 	parallelProcessingLimit:  2
	// 	setupTime:       20
	// 	cleanupTime:     20
	// 	hourlyProcessingCost:     130
	// 	costPerEmployee: 35
	// 	isActive:        true
	// }
	
}

WorkCenter: {
	items: [
		for k, v in #WorkCenter {
			v
		},
	]
}
