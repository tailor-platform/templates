package permissions

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
)

employee: {
	create: [
		{id: directories.roleMap.Admin.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Staff.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Manager.id, permit: tailordb.#Allow},
	]
	read: [
		{id: directories.roleMap.Admin.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Staff.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Manager.id, permit: tailordb.#Allow},
	]
	update: [
		{id: directories.roleMap.Admin.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Staff.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Manager.id, permit: tailordb.#Allow},
	]
	delete: [
		{id: directories.roleMap.Admin.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Staff.id, permit:   tailordb.#Allow},
		{id: directories.roleMap.Manager.id, permit: tailordb.#Allow},
	]
	admin: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
}
