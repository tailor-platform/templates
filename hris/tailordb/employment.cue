package employment

import (
	"{{ .Values.cue.package }}/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	employeeID: {
		type:        tailordb.#FieldTypeUUID
		description: "The employee ID of this employment."
	}
	employeeCode: {
		type:        tailordb.#FieldTypeString
		description: "The employee code for this employment."
	}
	jobTitle: {
		type:        tailordb.#FieldTypeString
		description: "The position's title."
	}
	payRate: {
		type:        tailordb.#FieldTypeInteger
		description: "The position's pay rate in dollars."
	}
	payPeriod: {
		type: tailordb.#FieldTypeEnum
		description: """
			The time period this pay rate encompasses.
			Expected values include: HOUR, DAY, WEEK, MONTH, QUARTER, YEAR
			"""
		values: ["HOUR", "DAY", "MONTH", "YEAR"]
	}
	payCurrency: {
		type: tailordb.#FieldTypeString
		description: """
			Currency code, ISO_4217.
			E.g., GBP, JPY, USD...
			"""
	}
	effectiveDate: {
		type:        tailordb.#FieldTypeDate
		description: "The position's effective date."
	}
	employmentType: {
		type: tailordb.#FieldTypeEnum
		description: """
			The position's type of employment.
			Expected values include: FULL_TIME, PART_TIME, INTERN, CONTRACTOR.
			"""
		values: ["FULLTIME", "PARTTIME", "INTERN", "CONTRACTOR"]
	}

}

Employment: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Employment model"
	permission:  permissions.employee
}
