package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

DailySchedule: tailordb.#Type & {
	Name:        "DailySchedule"
	Description: "Daily Schedule of the Working Hours. Used to define a day wise break up of the working hours."
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Indexes: {
		dailyScheduleUniquenessCompositeKey: {
			FieldNames: ["workingHoursId", "dayOfWeek", "workFrom", "workTo"]
			Unique: true
		}
	}
	Fields: {
		workingHoursId: {
			Type:        tailordb.#TypeUUID
			Description: "ID of the WorkingHour"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "WorkingHour"
		}
		workingHours: {
			Type:        "WorkingHour"
			Description: "Link to the WorkingHour"
			SourceId:    "workingHoursId"
		}
		dayOfWeek: {
			Type:        tailordb.#TypeEnum
			Description: "Day of the week"
			AllowedValues: [
				{Value: "Sunday", Description: "Sunday"},
				{Value: "Monday", Description: "Monday"},
				{Value: "Tuesday", Description: "Tuesday"},
				{Value: "Wednesday", Description: "Wednesday"},
				{Value: "Thursday", Description: "Thursday"},
				{Value: "Friday", Description: "Friday"},
				{Value: "Saturday", Description: "Saturday"},
			]
			Required:   true
		}
		workFrom: {
			Type:        tailordb.#TypeString
			Description: "Work from time. Format: HH:MM"
			Required:   true
		}
		workTo: {
			Type:        tailordb.#TypeString
			Description: "Work to time. Format: HH:MM"
			Required:   true
		}
		duration: {
			Type:        tailordb.#TypeInt
			Description: "Duration of the work in hours"
			Required:   true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
