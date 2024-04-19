package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

Contact: tailordb.#Type & {
	Name:        "Contact"
	Description: "Contact model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the Contact."
			Required:    true
		}
		isCustomer: {
			Type:        tailordb.#TypeBool
			Description: "Is the contact a customer?"
			Hooks: {
				CreateExpr: "_value != null ? _value : true"
			}
		}
		isVendor: {
			Type:        tailordb.#TypeBool
			Description: "Is the contact a vendor?"
			Hooks: {
				CreateExpr: "_value != null ? _value : true"
			}
		}
		inactive:{
			Type:		tailordb.#TypeBool
			Description: "Field used to delete the record. Instead of deleting the record, we set this field to true. This is to keep the data integrity."
			Hooks: {
				CreateExpr: "false"
			}
		}
		billingEmail: {
			Type:        tailordb.#TypeString
			Description: "Billing email of the contact."
			Validate: [{
				Expr: "!_value.matches('^\\\\s*[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\\\.[a-zA-Z0-9-]+)*\\\\s*$')"
				Action: "deny"
				ErrorMessage: "Invalid email."
			}]
			Required: true
		}
		billingAddress: {
			Type:        tailordb.#TypeString
			Description: "Billing address of the contact."
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
