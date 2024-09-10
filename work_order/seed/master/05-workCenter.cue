package master

import (
	"tailor.build/template/seed/utils"
)

#WorkCenter: {
	workCenter0: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "1"}
		name:        "Assembly Center"
		description: "Center for assembly operations"
		code:        "WCA-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.85
		parallelProcessingLimit:        2
		setupTime:       30
		cleanupTime:     15
		hourlyProcessingCost:     100
		costPerEmployee: 20
		isActive:        true
	}
	workCenter1: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "2"}
		name:        "Packing Center"
		description: "Center for packing operations"
		code:        "WCP-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  0.9
		parallelProcessingLimit:        2
		setupTime:       20
		cleanupTime:     10
		hourlyProcessingCost:     80
		costPerEmployee: 15
		isActive:        true
	}
	workCenter2: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "3"}
		name:        "Quality Control Center"
		description: "Center for quality control"
		code:        "WCQC-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "2"}
		timeEfficiency:  0.95
		parallelProcessingLimit:        4
		setupTime:       0
		cleanupTime:     0
		hourlyProcessingCost:     10
		costPerEmployee: 25
		isActive:        false
	}
	workCenter3: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "4"}
		name:        "Casting Center"
		description: "Center for Casting metal"
		code:        "WCCC-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  1.0
		parallelProcessingLimit:        50
		setupTime:       15
		cleanupTime:     15
		hourlyProcessingCost:     100
		costPerEmployee: 45
		isActive:        true
	}
	workCenter4: {
		id: utils.uuid & {_, #type: "WorkCenter", #value: "5"}
		name:        "Painting Center"
		description: "Center for painting"
		code:        "WCP-001"
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		timeEfficiency:  1.0
		parallelProcessingLimit:        3
		setupTime:       15
		cleanupTime:     15
		hourlyProcessingCost:     100
		costPerEmployee: 45
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
