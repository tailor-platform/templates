package master

import (
	"tailor.build/template/seed/utils"
)

#Tasks: {
	task1: {
		id: utils.uuid & {_, #type: "task", #value: "1"}
        projectId: "c38967c2-2fc7-4bf4-8de2-b4f7aa71f90a"
        assigneeId: "d5dd1b67-5167-53dd-92e9-690a0bf82ae0"
        name: "Design Homepage Mockups"
        description: "Create initial mockups for homepage redesign"
        dueDate:"2024-11-25T10:00:00Z"
        status: "In Progress"
    }
    task2: {
		id: utils.uuid & {_, #type: "task", #value: "2"}
        projectId: "fdf488be-39c2-4155-ad81-901d4d4e31ad"
        assigneeId: "b49ed20e-d311-53c2-a1d9-9f9e667a7664"
        name: "User Profile Module"
        description: "Implement user profile functionality"
        dueDate:"2024-10-30T10:00:00Z"
        status: "Completed"
    }
    task3: {
		id: utils.uuid & {_, #type: "task", #value: "3"}
        projectId: "fdf488be-39c2-4155-ad81-901d4d4e31ad"
        assigneeId: "2539cd36-854f-5ef0-8315-169650d16a62"
        name: "Mobile App Architecture"
        description: "Design initial app architecture"
        dueDate:"2025-01-01T10:00:00Z"
        status: "Not Started"
    }
}

Task: {
	items: [
		for k, v in #Tasks {
			v
		},
	]
}