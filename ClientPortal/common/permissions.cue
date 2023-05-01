package permissions

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
)

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
