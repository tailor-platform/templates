package ims

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb:permissions"
	"tailor.build/template/services/tailordb:commonType"
)

CostPool: commonType.#CommonType & {
	Name:        "CostPool"
	Description: "CostPool model"
	Fields: {
		name: {
			Type:        tailordb.#TypeString
			Description: "name"
			Required:    true
		}
		isClosed: {
			Type:        tailordb.#TypeBool
			Description: "isClosed"
			Hooks: {
				CreateExpr: "false"
			}
		}
		closedAt: {
			Type:        tailordb.#TypeDateTime
			Description: "closedAt"
			Hooks: {
				UpdateExpr: "_value.isClosed ? now() : null"
			}
		}
	}
	TypePermission: permissions.adminAccess
}
