package permissions

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	role "tailor.build/template/seed/master"
)

strict: {
	Create: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Staff.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Manager.id, Permit: tailordb.#Permit.Allow},
	]
	Read: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Staff.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Manager.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Customer.id, Permit: tailordb.#Permit.Allow},
	]
	Update: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Staff.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Manager.id, Permit: tailordb.#Permit.Allow},
	]
	Delete: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
	]
	Admin: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Staff.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Manager.id, Permit: tailordb.#Permit.Allow},
	]
}
