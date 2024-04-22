package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

Lead: tailordb.#Type & {
	Name:        "Lead"
	Description: "Lead model"
	Fields: {
		leadSource: {
			Type:        tailordb.#TypeString
			Description: "The lead's source."
		}
		companyName: {
			Type:        tailordb.#TypeString
			Description: "The lead's company name."
		}
		convertedDate: {
			Type:        tailordb.#TypeDate
			Description: "When the lead was converted."
		}
		convertedAccountID: {
			Type:        tailordb.#TypeUUID
			Description: "The account id of the converted lead."
		}
		engagementID: {
			Type:        tailordb.#TypeUUID
			Description: "The lead's engagement."
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
		dealAmount: {
			Type:        tailordb.#TypeString
			Description: "The lead's deal amount."
		}
		stage: {
			Type:        tailordb.#TypeEnum
			Description: "The lead's sales stage."
			AllowedValues: [
					{Value: "Open", Description:     "Open type"},
					{Value: "WIP", Description:      "Work in progress type"},
					{Value: "Lost", Description:     "Lost type"},
					{Value: "Won", Description:      "Won type"}
				]
			Hooks: {
				CreateExpr: """
					_value != null ? _value : 'Open'
				"""
			}
		}
	}

	TypePermission: permissions.employee
}