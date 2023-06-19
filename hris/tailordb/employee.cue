package employee

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	user: {
		type:        "User"
		description: "Directory User data for this employee"
		sourceId:    "userID"
	}
	userID: {
		type:        tailordb.#FieldTypeUUID
		description: "The employee's user id in directory service."
		foreignKey:  true
	}
	personalData: {
		type:        "PersonalData"
		description: "The employee who has this personal data"
		sourceId:    "personalDataID"
	}
	personalDataID: {
		type:        tailordb.#FieldTypeUUID
		description: "The employee's home addressID."
	}
	employment: {
		type:        "Employment"
		description: "The employee who has this personal data"
		sourceId:    "employmentID"
	}
	employmentID: {
		type:        tailordb.#FieldTypeUUID
		description: "The employee's home addressID."
	}
	employeeCode: {
		type:        tailordb.#FieldTypeString
		description: "The employee's code managed in the company"
	}
	firstName: {
		type:        tailordb.#FieldTypeString
		description: "The employee's first name."
	}
	lastName: {
		type:        tailordb.#FieldTypeString
		description: "The employee's last name."
	}
	displayName: {
		type:        tailordb.#FieldTypeString
		description: "The employee's name to display."
	}
	workEmail: {
		type:        tailordb.#FieldTypeString
		description: "The employee's work email."
	}
	mobilePhoneNumber: {
		type:        tailordb.#FieldTypeString
		description: "The employee's mobile phone number."
	}
	avatar: {
		type:        tailordb.#FieldTypeString
		description: "The URL of the employee's avatar image."
	}

}

Employee: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Employee model"
	permission:  permissions.employee
}
