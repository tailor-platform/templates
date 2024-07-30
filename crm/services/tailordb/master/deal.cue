package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
)

Deal: tailordb.#Type & {
	Name:        "Deal"
	Description: "Deal description"
	Settings: {
		Aggregation: true
	}
	Fields: {
		amount: {
			Type:        tailordb.#TypeFloat
			Description: "Deal amount"
			Required:    true
		}
		probability: {
			Type:        tailordb.#TypeFloat
			Description: "Deal probability."
			Required:    true
		}
		value: {
			Type:        tailordb.#TypeFloat
			Description: "Deal value"
			Hooks: {
				CreateExpr: "decimal(_value.amount * _value.probability)"
				UpdateExpr: "decimal(_value.amount * _value.probability)"
			}
		}
		isDeleted: {
			Type:        tailordb.#TypeBool
			Description: "Is Deleted?"
			Hooks: {
				CreateExpr: "false"
			}
		}
		dealStageId: {
			Type:        tailordb.#TypeUUID
			Description: "DealStage ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "DealStage"
		}
		dealStage: {
			Type:        "DealStage"
			Description: "Link to the DealStage"
			SourceId:    "dealStageId"
		}
		userId: {
			Type:        tailordb.#TypeUUID
			Description: "User ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "User"
		}
		user: {
			Type:        "User"
			Description: "Link to the User"
			SourceId:    "userId"
		}
		companyId: {
			Type:        tailordb.#TypeUUID
			Description: "Company ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Company"
		}
		company: {
			Type:        "Company"
			Description: "Link to the Company"
			SourceId:    "companyId"
		}
		contactId: {
			Type:        tailordb.#TypeUUID
			Description: "Contact ID"
			Required:    true
			ForeignKey:  true
			ForeignKeyType: "Contact"
		}
		contact: {
			Type:        "Contact"
			Description: "Link to the Contact"
			SourceId:    "contactId"
		}
		createdAt: tailordb.CreatedAtField
		updatedAt: tailordb.UpdatedAtField
	}
	TypePermission: permissions.employee
}
