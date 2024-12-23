package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

CostPoolLineItem: commonType.#CommonType & {
	Name:        "CostPoolLineItem"
	Description: "CostPoolLineItem model"
	Settings: {
		BulkUpsert:  true
		Aggregation: true
	}
	Fields: {
		costPoolID: {
			Type:        tailordb.#TypeUUID
			Description: "costPool ID"
			Required:    true
		}
		costPool: {
			Type:        "CostPool"
			Description: "CostPool model. CostPool and this model is n:1."
			SourceId:    "costPoolID"
		}
		name: {
			Type:        tailordb.#TypeString
			Description: "name"
			Required:    true
		}
		amount: {
			Type:        tailordb.#TypeFloat
			Description: "amount"
			Required:    true
		}
		allocationBase: {
			Type:        tailordb.#TypeEnum
			Description: "allocationBase"
			AllowedValues: [
				{Value: "DOLLAR_AMOUNT", Description: "DOLLAR_AMOUNT item"},
				{Value: "VOLUME", Description: "VOLUME item"},
			]
			Required: true
		}
	}
	TypePermission: permissions.adminAccess
}
