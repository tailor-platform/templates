package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Contact: tailordb.#Type & {
	Name:        "Contact"
	Description: "Contact Model"
	Fields: {
		isDeleted: {
			Type:        tailordb.#TypeBool
			Description: "Is Deleted?"
			Hooks: {
				CreateExpr: "false"
			}
		}
		firstName: {
			Type:        tailordb.#TypeString
			Description: "First Name of the Contact"
			Required:    true
		}
		lastName: {
			Type:        tailordb.#TypeString
			Description: "Last Name of the Contact"
		}
		email: {
			Type:        tailordb.#TypeString
			Description: "E-mail"
			Required:    true
		}
		phonePrimary: {
			Type:        tailordb.#TypeString
			Description: "Primary Phone Number"
			Required:    true
		}
		linkedInUrl: {
			Type:        tailordb.#TypeString
			Description: "LinkedIn URL"
		}
		companyId: {
			Type:        tailordb.#TypeUUID
			Description: "Company ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Company"
		}
		company: {
			Type:        "Company"
			Description: "Link to the Company"
			SourceId:    "companyId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
