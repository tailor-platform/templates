package master

import (
	"tailor.build/template/seed/utils"
)

#Projects: {
	project1: {
		id: utils.uuid & {_, #type: "project", #value: "1"}
        name: "Mobile App Development"
        description: "New mobile app for customers"
        status: "In Progress"
        startDate: "2024-09-01"
        endDate:"2025-03-31"
    }
    project2: {
		id: utils.uuid & {_, #type: "project", #value: "2"}
        name: "API Integration"
        description: "Integration with payment gateway"
        startDate: "2024-10-15"
        endDate:"2025-04-30"
        status: "In Progress"
    }
    project3: {
		id: utils.uuid & {_, #type: "project", #value: "3"}
        name: "Performance Optimization"
        description: "System-wide performance improvements"
        startDate: "2025-02-01"
        endDate:"2025-05-31"
        status: "Planning"
    }
}

Project: {
	items: [
		for k, v in #Projects {
			v
		},
	]
}
