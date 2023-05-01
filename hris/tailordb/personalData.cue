package personalData

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	employeeID: {
		type:        tailordb.#FieldTypeUUID
		description: "The employee ID of this personal data."
	}
	personalEmail: {
		type:        tailordb.#FieldTypeString
		description: "The employee's personal email."
	}
	socialSecurityNumber: {
		type:        tailordb.#FieldTypeString
		description: "The employee's social security number."
	}
	dateOfBirth: {
		type:        tailordb.#FieldTypeDate
		description: "The employee's date of birth."
	}
	hireDate: {
		type:        tailordb.#FieldTypeDate
		description: "The date that the employee was hired, usually the day that an offer letter is signed. If an employee has multiple hire dates from previous employments, this represents the most recent hire date. Note: If you're looking for the employee's start date, refer to the start_date field."
	}
	startDate: {
		type:        tailordb.#FieldTypeDate
		description: "The date that the employee started working. If an employee has multiple start dates from previous employments, this represents the most recent start date."
	}
	employmentStatus: {
		type: tailordb.#FieldTypeEnum
		description: """
			The employment status of the employee.
			Expected values include: ACTIVE, PENDING, INACTIVE.
			"""
		values: ["ACTIVE", "PENDING", "INACTIVE"]
	}
	terminationDate: {
		type:        tailordb.#FieldTypeDate
		description: "The employee's termination date."
	}

}

PersonalData: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "PersonalData model"
	permission:  permissions.employee
}
