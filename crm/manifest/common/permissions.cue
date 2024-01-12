package permissions

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
)

everyone: {
	create: [
		{id: tailordb.#Everyone, permit:   tailordb.#Allow},
	]
	read: [
		{id: tailordb.#Everyone, permit:   tailordb.#Allow},
	]
	update: [
		{id: tailordb.#Everyone, permit:   tailordb.#Allow},
	]
	delete: [
		{id: tailordb.#Everyone, permit:   tailordb.#Allow},
	]
	admin: [
		{id: tailordb.#Everyone, permit:   tailordb.#Allow},
	]
}
