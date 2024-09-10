package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

BomLineItem: tailordb.#Type & {
	Name:        "BomLineItem"
	Description: "BOMLineItem description"
	Settings: {
		BulkUpsert: true
	}
	Indexes: {
		bomItemCompositeKey: {
			FieldNames: ["bomId", "itemId"]
			Unique: true
		}
	}
	Fields: {
		bomId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated BOM"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Bom"
		}
		bom: {
			Type:        "Bom"
			Description: "Link to the BOM"
			SourceId:    "bomId"
		}
		itemId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated item"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Item"
		}
		item: {
			Type:        "Item"
			Description: "Link to the Item"
			SourceId:    "itemId"
		}
		inputQuantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of input items required"
			Hooks: {
				CreateExpr: "_value != null ? value : decimal(1.0)"
			}
		}
		uomId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the unit of measure"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Uom"
		}
		uom: {
			Type:        "Uom"
			Description: "Link to the Unit of Measure"
			SourceId:    "uomId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
