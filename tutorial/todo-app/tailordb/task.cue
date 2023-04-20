package task

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
)

Task: tailordbv1.#TypeConfig & {
        description: "Task data schema"
		fields: {
			"description": {
				type:        tailordb.#FieldTypeString
				description: "A description of the task"
			}
			"priority": {
				type:        tailordb.#FieldTypeInteger
				description: "A priority of the task"
			}
        }
		permission: {
			create:
			[
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
				{id: tailordb.#EveryoneUserID, permit: tailordb.#Allow},
			]
	    }
}
