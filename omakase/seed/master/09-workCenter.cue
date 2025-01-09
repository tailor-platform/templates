package master

import (
	"tailor.build/template/seed/utils"
)

#WorkCenter: {
	workCenter0: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "1"}
		name:        "Base Assembly Center"
		description: "Center dedicated to assembling sub-components of the hat crown"
		code:        "WCE-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.85
		parallelProcessingLimit:  2
		setupTime:       30
		cleanupTime:     30
		hourlyProcessingCost:     150
		costPerEmployee: 30
		isActive:        true
	}
	
	workCenter1: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "2"}
		name:        "Frame Assembly Center"
		description: "Center for assembling the hat's structural panels"
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
	
	workCenter2: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "3"}
		name:        "Electrical Systems Center"
		description: "Center for attaching patches, labels, or minor attachments"
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
	
	workCenter3: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "4"}
		name:        "Casting Center"
		description: "Center for shaping brims or applying special forms"
		code:        "WCCC-002"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  1.0
		parallelProcessingLimit:  2
		setupTime:       25
		cleanupTime:     25
		hourlyProcessingCost:     130
		costPerEmployee: 50
		isActive:        true
	}
	
	workCenter4: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "5"}
		name:        "Painting Center"
		description: "Center for dyeing or painting the hat components"
		code:        "WCP-002"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  1.0
		parallelProcessingLimit:  3
		setupTime:       20
		cleanupTime:     20
		hourlyProcessingCost:     110
		costPerEmployee: 35
		isActive:        true
	}
	
	workCenter5: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "6"}
		name:        "Final Assembly Center"
		description: "Center for integrating all hat components into final product"
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
	
	workCenter6: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "7"}
		name:        "Quality Control Center"
		description: "Center for testing and QA of completed hats"
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
	
	workCenter7: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "8"}
		name:        "Packaging Center"
		description: "Center for packaging completed Ace Iconic Performance Hats"
		code:        "WCP-002"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.9
		parallelProcessingLimit:  3
		setupTime:       15
		cleanupTime:     10
		hourlyProcessingCost:     100
		costPerEmployee: 25
		isActive:        true
	}
}

WorkCenter: {
	items: [
		for k, v in #WorkCenter {
			v
		},
	]
}
