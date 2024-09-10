package permissions

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	role "tailor.build/template/seed/master"
)

editorAccess: tailordb.#TypePermissions & {
	Create: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Editor.id, Permit: tailordb.#Permit.Allow},
	]
	Read: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Editor.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Viewer.id, Permit: tailordb.#Permit.Allow},
	]
	Update: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Editor.id, Permit: tailordb.#Permit.Allow},
	]
	Delete: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Editor.id, Permit: tailordb.#Permit.Allow},
	]
	Admin: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Editor.id, Permit: tailordb.#Permit.Deny},
	]
}

adminAccess: tailordb.#TypePermissions & {
	Create: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
	]
	Read: [
		{Id: role.#Roles.Admin.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Editor.id, Permit: tailordb.#Permit.Allow},
		{Id: role.#Roles.Viewer.id, Permit: tailordb.#Permit.Allow},
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
