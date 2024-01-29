package type

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
)

Character: tailordb.#Type & {
	name:        "Character"
	description: "Character data schema"
	fields: {
		name: {
			type:        tailordb.#TypeString
			description: "Name of the character"
			index:       true
			required:    true
		}
		email: {
			type:        tailordb.#TypeString
			description: "Email address of the character"
			index:       true
			unique:      true
			required:    true
		}
		roles: {
			type:        tailordb.#TypeUUID
			description: "Role IDs of the character"
			array:       true
		}
		affiliations: {
			type:        tailordb.#TypeUUID
			description: "Affiliation IDs of the character"
			array:       true
		}
		speciesID: {
			type:           tailordb.#TypeUUID
			description:    "Species ID of the character"
			index:          true
			required:       true
			foreignKey:     true
			foreignKeyType: "Species"
		}
		species: {
			type:        "Species"
			description: "Species of the character"
			sourceId:    "speciesID"
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
