package bom

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

UomConversion: tailordb.#Type & {
	Name:        "UomConversion"
	Description: "UOMConversion description"
	Settings: {
		BulkUpsert: true
	}
	Indexes: {
		uomConversionCompositeKey: {
			FieldNames: ["fromUomId", "toUomId"]
			Unique:     true
		}
	}
	Fields: {
		fromUomId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the source unit of measure"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Uom"
		}
		fromUom: {
			Type:        "Uom"
			Description: "Link to the source Unit of Measure"
			SourceId:    "fromUomId"
		}
		toUomId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the target unit of measure"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Uom"
		}
		toUom: {
			Type:        "Uom"
			Description: "Link to the target Unit of Measure"
			SourceId:    "toUomId"
		}
		conversionFactor: {
			Type:        tailordb.#TypeFloat
			Description: "Factor used to convert between units"
			Required:    true
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
