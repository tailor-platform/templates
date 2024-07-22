package master

import (
	"tailor.build/template/services/tailordb:permissions"
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
)

State: tailordb.#Type & {
	Name:    "State"
	Extends: true
	Directives: [{
		Name: "key"
		Args: [
			{
				name:  "fields"
				value: "id"
			},
		]
	}]
	Description:    "state model"
	TypePermission: permissions.strict
}
