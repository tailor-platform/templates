package type

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
)

Affiliation: tailordb.#Type & {
	name:        "Affiliation"
	description: "Affiliation"
	fields: {
		name: {
			type:        tailordb.#TypeString
			description: "Name"
			index:       true
			required:    true
		}
	}
	typePermission: {
		create: [
			{id: tailordb.#Everyone, permit: tailordb.#Permit.Allow},
		]
		read: [
			{id: tailordb.#Everyone, permit: tailordb.#Permit.Allow},
		]
		update: [
			{id: tailordb.#Everyone, permit: tailordb.#Permit.Allow},
		]
		delete: [
			{id: tailordb.#Everyone, permit: tailordb.#Permit.Allow},
		]
		admin: [
			{id: tailordb.#Everyone, permit: tailordb.#Permit.Allow},
		]
	}
}
