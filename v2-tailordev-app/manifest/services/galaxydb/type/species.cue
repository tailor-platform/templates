package type

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
)

Species: tailordb.#Type & {
	name:        "Species"
	description: "Species"
	fields: {
		name: {
			type:        tailordb.#TypeString
			description: "Name of the species"
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
