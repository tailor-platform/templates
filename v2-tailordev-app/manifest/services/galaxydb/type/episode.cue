package type

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
)

Episode: tailordb.#Type & {
	name:        "Episode"
	description: "Episode data schema"
	fields: {
		title: {
			type:        tailordb.#TypeString
			description: "Title of the episode"
		}
		characters: {
			type:        tailordb.#TypeNested
			description: "Characters of the episode"
			array:       true
			fields: {
				characterID: {
					type:           tailordb.#TypeUUID
					description:    "ID of the character"
					foreignKey:     true
					foreignKeyType: "Character"
				}
				character: {
					type:     "Character"
					sourceId: "characterID"
					required: true
				}
			}
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
