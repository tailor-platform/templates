package workOrder

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

WorkCenter: tailordb.#Type & {
	Name:        "WorkCenter"
	Description: "Work Center are the physical locations where the production happens"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Work Center Name"
			Required:   true
		}
		description: {
			Type:        tailordb.#TypeString
			Description: "Work Center Description"
		}
		code: {
			Type:        tailordb.#TypeString
			Description: "Work station identification short code"
			Required:   true
		}
		workingHoursId: {
			Type:        tailordb.#TypeUUID
			Description: "ID of the Working hours for the work center"
			Required:   true
			ForeignKey: true
			ForeignKeyType: "WorkingHour"
		}
		workingHours: {
			Type:        "WorkingHour"
			Description: "Link to the Working Hours for the work center"
			SourceId:    "workingHoursId"
		}
		timeEfficiency: {
			Type:        tailordb.#TypeFloat
			Description: """
			% efficiency of a work center,
			eg. If the operational time is 60 mins, and efficiency is 50%
			then the usage time will be calculated as 120 mins because the work center is operating slower.
			Ranges from 0 to 100.
			"""
			Required:   true
		}
		parallelProcessingLimit: {
			Type:        tailordb.#TypeInt
			Description: "Number of items that can be parallelly processed"
			Validate: [
				{
					Expr: "_value < 1"
					Action: tailordb.#Permit.Deny
					ErrorMessage: "Capacity should be atleast 1"
				}
			]
			Required:   true
		}
		setupTime: {
			Type:        tailordb.#TypeInt
			Description: "Setup time required to get the work center ready before each work order"
			Validate: [
				{
					Expr: "_value < 0"
					Action: tailordb.#Permit.Deny
					ErrorMessage: "Setup time cannot be negative"
				}
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		cleanupTime: {
			Type:        tailordb.#TypeInt
			Description: "Clean time required to get the work center ready for the next work order"
			Validate: [
				{
					Expr: "_value < 0"
					Action: tailordb.#Permit.Deny
					ErrorMessage: "Cleanup time cannot be negative"
				}
			]
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		hourlyProcessingCost: {
			Type:        tailordb.#TypeInt
			Description: "Hourly processing cost of the center. Includes electricity cost, average usage cost, rental cost etc."
			Required:   true
		}
		costPerEmployee: {
			Type:        tailordb.#TypeInt
			Description: "Hourly cost of the employee at the work center"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : 0
				"""
			}
		}
		isActive: {
			Type:        tailordb.#TypeBool
			Description: "Is the work center active?"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : true
				"""
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
