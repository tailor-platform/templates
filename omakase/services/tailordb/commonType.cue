package commonType

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
)

#CommonType: tailordb.#Type & {
	Fields: {
		[string]: tailordb.#Field
		active: {
			Type:        tailordb.#TypeBool
			Description: "active"
			Hooks: {
				CreateExpr: "true"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
}
