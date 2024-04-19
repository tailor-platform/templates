package master

import (
  "github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb/permissions"
)

Supplier: tailordb.#Type & {
	Name:        "Supplier"
	Description: "Supplier account"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		code: {
			Type:        tailordb.#TypeString
			Description: "Supplier code."
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the supplier."
			Required:    true
		}
		companyName: {
			Type:        tailordb.#TypeString
			Description: "Company name of the supplier."
		}
		contactNumber: {
			Type:        tailordb.#TypeString
			Description: "Contact number of the supplier."
		}
		email: {
			Type:        tailordb.#TypeString
			Description: "Email address of the supplier."
		}
		address: {
			Type:        tailordb.#TypeString
			Description: "Physical address of the supplier."
		}
		status: {
			Type: tailordb.#TypeEnum
			AllowedValues: [
				{ Value: "active", Description: "Active supplier." },
				{ Value: "inactive", Description: "Inactive supplier." }
			]
			Description: "Status of the supplier."
		}
		userID: {
			Type:        tailordb.#TypeUUID
			Description: "User ID of the supplier."
			// temporary disabled for development
			// required:  true
		}
	}
	TypePermission: permissions.adminAccess
}
