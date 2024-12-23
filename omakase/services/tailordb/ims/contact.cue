package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

Contact: commonType.#CommonType & {
	Name:        "Contact"
	Description: "Contact model"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "name"
			Required:    true
		}
		email: {
			Type:        tailordb.#TypeString
			Description: "email"
			Required:    true
		}
		phone: {
			Type:        tailordb.#TypeString
			Description: "phone"
		}
		address1: {
			Type:        tailordb.#TypeString
			Description: "address1"
		}
		address2: {
			Type:        tailordb.#TypeString
			Description: "address2"
		}
		city: {
			Type:        tailordb.#TypeString
			Description: "city"
		}
		province: {
			Type:        tailordb.#TypeString
			Description: "province"
		}
		country: {
			Type:        tailordb.#TypeString
			Description: "country"
		}
		zip: {
			Type:        tailordb.#TypeString
			Description: "zip"
		}
		countryCode: {
			Type:        tailordb.#TypeString
			Description: "countryCode"
		}
		company: {
			Type:        tailordb.#TypeString
			Description: "company"
		}
		provinceCode: {
			Type:        tailordb.#TypeString
			Description: "province_code"
		}

		quickBookCustomerId: {
			Type:        tailordb.#TypeString
			Description: "the reference id of the customer in quickbook"
		}
		openBalance: {
			Type:        tailordb.#TypeFloat
			Description: "The amount of open balance of the customer."
			Hooks: {
				CreateExpr: "_value == null ? decimal(0.0) : _value"
				UpdateExpr: CreateExpr
			}
		}
		creditLimit: {
			Type:        tailordb.#TypeFloat
			Description: "The amount of credit limit of the customer."
			Hooks: {
				CreateExpr: "_value == null ? decimal(0.0) : _value"
				UpdateExpr: CreateExpr
			}
		}
		availableCredit: {
			Type:        tailordb.#TypeFloat
			Description: "The amount of credit available to the customer."
			Hooks: {
				CreateExpr: "_value.creditLimit == null || _value.openBalance == null ? decimal(0.0) : decimal(_value.creditLimit) - decimal(_value.openBalance)"
				UpdateExpr: CreateExpr
			}
		}

	}
	TypePermission: permissions.adminAccess
}
