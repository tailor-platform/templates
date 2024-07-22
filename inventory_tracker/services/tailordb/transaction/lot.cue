package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Lot: tailordb.#Type & {
	Name:        "Lot"
	Description: "Model for Lot. Lot is used for trasability. Lot takes PutAway as a foreign key. With this application, each Lot has one PutAway. This can be customized based on the requirement."
	Fields: {
		putAway: {
			Type:        "PutAway"
			Description: "PutAway model. Lot and PutAway is 1:1."
			SourceId:    "putAwayID"
		}
		putAwayID: {
			Type:        tailordb.#TypeUUID
			Description: "putAway ID"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
