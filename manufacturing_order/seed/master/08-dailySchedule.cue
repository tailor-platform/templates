package master

import (
	"tailor.build/template/seed/utils"
)

#DailySchedule: {
	dailySchedule0: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "1"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		dayOfWeek: "Monday"
		workFrom:  "09:00"
		workTo:    "17:00"
		duration:  8
	}
	dailySchedule1: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "2"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		dayOfWeek: "Tuesday"
		workFrom:  "09:00"
		workTo:    "17:00"
		duration:  8
	}
	dailySchedule2: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "3"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		dayOfWeek: "Wednesday"
		workFrom:  "09:00"
		workTo:    "17:00"
		duration:  8
	}
	dailySchedule3: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "4"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		dayOfWeek: "Thursday"
		workFrom:  "09:00"
		workTo:    "17:00"
		duration:  8
	}
	dailySchedule4: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "5"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "1"}
		dayOfWeek: "Friday"
		workFrom:  "09:00"
		workTo:    "17:00"
		duration:  8
	}
	dailySchedule5: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "6"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "2"}
		dayOfWeek: "Monday"
		workFrom:  "01:00"
		workTo:    "04:00"
		duration:  8
	}
	dailySchedule6: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "7"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "2"}
		dayOfWeek: "Tuesday"
		workFrom:  "01:00"
		workTo:    "04:00"
		duration:  8
	}
	dailySchedule7: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "8"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "2"}
		dayOfWeek: "Wednesday"
		workFrom:  "01:00"
		workTo:    "04:00"
		duration:  8
	}
	dailySchedule8: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "9"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "2"}
		dayOfWeek: "Thursday"
		workFrom:  "01:00"
		workTo:    "04:00"
		duration:  8
	}
	dailySchedule9: {
		id: utils.uuid & {_, #type: "DailySchedule", #value: "10"}
		workingHoursId: utils.uuid & {_, #type: "WorkingHour", #value: "2"}
		dayOfWeek: "Friday"
		workFrom:  "01:00"
		workTo:    "04:00"
		duration:  8
	}
}

DailySchedule: {
	items: [
		for k, v in #DailySchedule {
			v
		},
	]
}
