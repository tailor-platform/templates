package permissions

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
)

loggedinUser: {
	create: [
		{id: tailordb.#LoggedInUser, permit: tailordb.#Allow},
	]
	read: [
		{id: tailordb.#LoggedInUser, permit: tailordb.#Allow},
	]
	update: [
		{id: tailordb.#LoggedInUser, permit: tailordb.#Allow},
	]
	delete: [
		{id: tailordb.#LoggedInUser, permit: tailordb.#Allow},
	]
	admin: [
		{id: directories.roleMap.Admin.id, permit: tailordb.#Allow},
	]
}
