package transaction

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Document: tailordb.#Type & {
	Name:        "Document"
	Description: "Document model"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		documentType: {
			Type:        "DocumentType"
			Description: "DocumentType model. Document and DocumentType is n:1."
			SourceId:    "documentTypeID"
		}
		documentTypeID: {
			Type:        tailordb.#TypeUUID
			Description: "documentType ID"
			Required:    true
		}
		documentTemplate: {
			Type:        "DocumentTemplate"
			Description: "Document Template model. Document and DocumentTemplate is n:1."
			SourceId:    "documentTemplateID"
		}
		documentTemplateID: {
			Type:        tailordb.#TypeUUID
			Description: "documentTemplate ID"
		}
		contact: {
			Type:        "Contact"
			Description: "Contact model. Document and Contact is n:1."
			SourceId:    "contactID"
		}
		contactID: {
			Type:        tailordb.#TypeUUID
			Description: "contact ID"
		}
		code: {
			Type:        tailordb.#TypeString
			Description: "Document code. Recommended to be unique but not enforced for now."
		}
		date: {
			Type:        tailordb.#TypeDate
			Description: "Refer to the Document Template for the usage."
		}
		documentStatusID: {
			Type:        tailordb.#TypeUUID
			Description: "documentStatus ID"
		}
		documentStatus: {
			Type:        "DocumentStatus"
			Description: "Document Status model. Document and DocumentStatus is n:1."
			SourceId:    "documentStatusID"
		}
		paymentDueDate: {
			Type:        tailordb.#TypeDate
			Description: "Due Date of the payment. Used for an Invoice."
		}
		paymentAmount: {
			Type:        tailordb.#TypeFloat
			Description: "Amount of the payment. Used for an Invoice."
		}
		subtotalAmount: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END: The subtotal amount of the all line items included in this document."
		}
		subtotalCost: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END: The subtotal cost of the all line items included in this document."
		}
		taxAmount: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END: The tax amount of the all line items included in this document."
		}
		totalAmount: {
			Type:        tailordb.#TypeFloat
			Description: "DO NOT UPDATE FROM THE FRONT END: The total amount (subtotal + tax) of the all line items included in this document."
		}
		isCalculated: {
			Type:        tailordb.#TypeBool
			Description: "Provide false as the input when you are creating or updating the line item from the front end."
			Required:    true
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
