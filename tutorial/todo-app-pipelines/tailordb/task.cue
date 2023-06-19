package task

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

Task: tailordbv1.#TypeConfig & {
	description: "Task data schema"
	fields: {
		title: {
			type:        tailordb.#FieldTypeString
			description: "Title of the task"
		}
		priority: {
			type:        tailordb.#FieldTypeInteger
			description: "Priority of the task"
		}
		assignedUserID: {
			type:        tailordb.#FieldTypeUUID
			description: "UUID of the User assigned to this task"
		}
	}
	permission: {
		create: [
			{id: tailordb.#Everyone, permit: tailordb.#Allow},
		]
		read: [
			{id: tailordb.#Everyone, permit: tailordb.#Allow},
		]
		update: [
			{id: tailordb.#Everyone, permit: tailordb.#Allow},
		]
		delete: [
			{id: tailordb.#Everyone, permit: tailordb.#Allow},
		]
		admin: [
			{id: tailordb.#Everyone, permit: tailordb.#Allow},
		]
	}
}
