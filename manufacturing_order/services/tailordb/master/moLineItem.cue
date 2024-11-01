package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

MOLineItem: tailordb.#Type & {
	Name:        "MOLineItem"
	Description: "MOLineItem description"
	Settings: {
		BulkUpsert: true
		Aggregation: true
	}
	Indexes: {
		moLineItemCompositeKey: {
			FieldNames: ["moId", "bomLineItemId"]
			Unique: true
		}
	}
	Fields: {
		moId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated MO"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "ManufacturingOrder"
		}
		mo: {
			Type:        "ManufacturingOrder"
			Description: "Link to the MO"
			SourceId:    "moId"
		}
		bomLineItemId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated bomLineItem"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "BomLineItem"
		}
		bomLineItem: {
			Type:        "BomLineItem"
			Description: "Link to the bomLineItem"
			SourceId:    "bomLineItemId"
		}
		requiredQuantity: {
			Type:        tailordb.#TypeInt
			Description: "The Quantity needed for the MO"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : decimal(1.0)
				"""
			}
		}
		totalCost: {
			Type:        tailordb.#TypeFloat
			Description: "Total cost of the component based on input quantity, uom and unit cost"
		}
		itemMoId: {
			Type:        tailordb.#TypeUUID
			Description: "Unique identifier of the associated MO if nested"
			ForeignKey:  true
			ForeignKeyType: "ManufacturingOrder"
		}
		itemMo: {
			Type:        "ManufacturingOrder"
			Description: "Link to the MO"
			SourceId:    "itemMoId"
		}
		isDeleted: {
			Type:        tailordb.#TypeBool
			Description: "isDeleted description"
			Hooks: {
				CreateExpr: """
				_value != null ? _value : false
				"""
			}
		}	
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.editorAccess
}
