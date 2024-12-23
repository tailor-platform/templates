package master

import (
	"tailor.build/template/seed/utils"
)

#WorkingHour: {
	workingHours0: {
		id: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		name:                 "Standard Working Hours"
		standardHoursPerWeek: 40
		timeZone:             "UTC"
		isActive:             true
	}
	workingHours1: {
		id: utils.uuid & {_, #type: "WorkingHour", #value: "2"}
		name:                 "Night Shift"
		standardHoursPerWeek: 20
		timeZone:             "UTC-2"
		isActive:             true
	}
}

WorkingHour: {
	items: [
		for k, v in #WorkingHour {
			v
		},
	]
}
