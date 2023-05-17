package permissions

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
)

admin: {
	create: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
	read: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
	update: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
	delete: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
	admin: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
}

loggedinUser: {
	create: [
		{id: tailordb.#LoggedInUserID, permit: tailordb.#Allow},
	]
	read: [
		{id: tailordb.#LoggedInUserID, permit: tailordb.#Allow},
	]
	update: [
		{id: tailordb.#LoggedInUserID, permit: tailordb.#Allow},
	]
	delete: [
		{id: tailordb.#LoggedInUserID, permit: tailordb.#Allow},
	]
	admin: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
}

everyone: {
	create: [
		{id: tailordb.#EveryoneUserID, permit: tailordb.#Allow},
	]
	read: [
		{id: tailordb.#EveryoneUserID, permit: tailordb.#Allow},
	]
	update: [
		{id: tailordb.#EveryoneUserID, permit: tailordb.#Allow},
	]
	delete: [
		{id: tailordb.#EveryoneUserID, permit: tailordb.#Allow},
	]
	admin: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
}

strict: {
	create: [
		{id: directories.roleMap.Admin.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Staff.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Manager.id, permit: tailordb.#Allow},
	]
	read: [
		{id: directories.roleMap.Admin.id, permit:    tailordb.#Allow},
		{id: directories.roleMap.Staff.id, permit:    tailordb.#Allow},
		{id: directories.roleMap.Manager.id, permit:  tailordb.#Allow},
		{id: directories.roleMap.Customer.id, permit: tailordb.#Allow},
	]
	update: [
		{id: directories.roleMap.Admin.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Staff.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Manager.id, permit: tailordb.#Allow},
	]
	delete: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
	admin: [
		{id: directories.roleMap.Admin.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Staff.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Manager.id, permit: tailordb.#Allow},
	]
}
