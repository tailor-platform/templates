package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
)

LineItem: tailordb.#Type & {
	Name:        "LineItem"
	Description: "Model for Line Item. Please be aware that some of the fields are not supposed to be updated from the front end."
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		document: {
			Type:        "Document"
			Description: "Document model. Line Item and Document is n:1."
			SourceId:    "documentID"
		}
		documentID: {
			Type:        tailordb.#TypeUUID
			Description: "document ID"
			Required:    true
		}
		product: {
			Type:        "Product"
			Description: "Product model. Line Item and Product is n:1."
			SourceId:    "productID"
		}
		productID: {
			Type:        tailordb.#TypeUUID
			Description: "Product ID"
			Required:    true
		}
		taxID: {
			Type:        tailordb.#TypeUUID
			Description: "Tax ID"
			Required:    true
		}
		tax: {
			Type:        "Tax"
			Description: "Tax model. Line Item and Tax is n:1."
			SourceId:    "taxID"
		}
		quantity: {
			Type:        tailordb.#TypeInt
			Description: "Quantity of the item"
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "Name of the product."
			Required: true
		}
		unitCost: {
			Type:        tailordb.#TypeFloat
			Description: "Unit cost of the product."
			Required: true
		}
		unitPrice: {
			Type:        tailordb.#TypeFloat
			Description: " Unit price of the product.'"
			Required: true
		}
		markup: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END, COMPUTED FIELD: Result of (Price - Cost)/Cost, in percent. A product priced at $45, which has the cost of $30, will have 0.5 (50%) as the markup. Default value is set as: '\(Hooks.CreateExpr)'"
			Hooks: {
				CreateExpr: """
						decimal(_value.unitCost) > 0 ? decimal(_value.unitPrice) - decimal(_value.unitCost) / decimal(_value.unitCost) : 0.0
					"""
				UpdateExpr: CreateExpr
			}
		}
		subtotalCost: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END, COMPUTED FIELD: Amount of unit times cost. Tax is not considered. Default value is set as: '\(Hooks.CreateExpr)'"
			Hooks: {
				CreateExpr: """
						decimal(_value.unitCost) * decimal(_value.quantity)
					"""
				UpdateExpr: CreateExpr
			}
		}
		subtotalAmount: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END, COMPUTED FIELD: Amount of unit times price, before tax. Default value is set as: '\(Hooks.CreateExpr)'"
			Hooks: {
				CreateExpr: """
						decimal(_value.unitPrice) * decimal(_value.quantity)
					"""
				UpdateExpr: CreateExpr
			}
		}
		taxAmount: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END, COMPUTED FIELD: Amount of total tax for this line items. Result of (subtotalAmount * tax.taxRate). Use bulkUspertAndCalculateLineItems pipeline instead"
		}
		totalAmount: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END, COMPUTED FIELD: Sum of total tax amount and subtotal amount for this line item. Default value is set as: '\(Hooks.CreateExpr)'"
			Hooks: {
				CreateExpr: """
						decimal(_value.unitPrice) * decimal(_value.quantity) + decimal(_value.taxAmount)
					"""
				UpdateExpr: CreateExpr
			}
		}
		isCalculated: {
			Type:        tailordb.#TypeBool
			Description: "Provide false as the input when you are creating or updating the line item from the front end."
			Required: true
		}
		inactive: {
			Type:        tailordb.#TypeBool
			Description: "Field used to delete the record. Instead of deleting the record, we set this field to true. This is to keep the data integrity."
			Hooks: {
				CreateExpr: "false"
			}
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}

	TypePermission: permissions.editorAccess
}
