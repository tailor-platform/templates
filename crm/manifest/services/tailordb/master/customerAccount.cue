package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

CustomerAccount: tailordb.#Type & {
	Name:        "CustomerAccount"
	Description: "CustomerAccount model"
	Fields: {
		lead: {
			Type:        "Lead"
			Description: "The account's lead"
			SourceId:    "leadID"
		}
		leadID: {
			Type:        tailordb.#TypeUUID
			Description: "The account lead ID."
		}
		companyName: {
			Type:        tailordb.#TypeString
			Description: "The account's name."
		}
		contact: {
			Type:        tailordb.#TypeNested
			Description: "The lead's contact."
			Fields: {
				contactName: {
					Type:        tailordb.#TypeString
					Description: "The lead's contact name."
				}
				emailAddress: {
					Type:        tailordb.#TypeString
					Description: "The lead's contact email address."
				}
				phoneNumber: {
					Type:        tailordb.#TypeString
					Description: "The lead's contact phone number."
				}
			}
		}
	}

	TypePermission: permissions.employee
}


