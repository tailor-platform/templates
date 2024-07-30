package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

ContactListMember: tailordb.#Type & {
	Name:        "ContactListMember"
	Description: "ContactListMember model"
	Settings: {
		BulkUpsert: true
	}
	Indexes: {
		contactListCompositeKey: {
			FieldNames: ["contactId", "contactListId"]
			Unique: true
		}
	}
	Fields: {
		contactId: {
			Type:        tailordb.#TypeUUID
			Description: "Contact ID"
			Required:    true
		}
		contact: {
			Type:        "Contact"
			Description: "Link to the Contact"
			SourceId:    "contactId"
		}
		contactListId: {
			Type:        tailordb.#TypeUUID
			Description: "ContactList ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "ContactList"
		}
		contactList: {
			Type:        "ContactList"
			Description: "Link to the ContactList"
			SourceId:    "contactListId"
		}
		addedAt: {
			Type:        tailordb.#TypeString
			Description: "Time when the contact was added to the list"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
