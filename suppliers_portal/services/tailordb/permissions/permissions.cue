package permissions

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	role "tailor.build/template/seed/master"
)

adminAccess: tailordb.#TypePermissions & {
	Create: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
	]
	Read: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
	]
	Update: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
	]
	Delete: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
	]
	Admin: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
	]
}
