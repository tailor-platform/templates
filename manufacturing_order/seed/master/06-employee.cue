package master

import (
	"tailor.build/template/seed/utils"
)

#Employee: {
	employee0: {
		id: utils.uuid & {_, #type: "Employee", #value: "1"}
		name: "Alice Johnson"
		role: "Engineer"
		isActive:true
	}
	employee1: {
		id: utils.uuid & {_, #type: "Employee", #value: "2"}
		name: "Bob Smith"
		role: "Technician"
		isActive:true
	}
	employee2: {
		id: utils.uuid & {_, #type: "Employee", #value: "3"}
		name: "Charlie Brown"
		role: "Manager"
		isActive:true
	}
}

Employee: {
	items: [
		for k, v in #Employee {
			v
		},
	]
}
