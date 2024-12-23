package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

Location: commonType.#CommonType & {
	Name:        "Location"
	Description: "Inventory location on Shopify"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the location"
		}
		shopifyID: {
			Type:        tailordb.#TypeString
			Description: "Shopify ID of the location"
		}
	}
	TypePermission: permissions.editorAccess
}
