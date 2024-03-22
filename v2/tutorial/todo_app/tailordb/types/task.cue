package types

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
)

Task: tailordb.#Type & {
	Name:        "Task"
	Description: "Task"
	Fields: {
		title: {
			Type:        tailordb.#TypeString
			Description: "Title of the task"
		}
		priority: {
			Type:        tailordb.#TypeInt
			Description: "Priority of the task"
		}
	}
	TypePermission: {
		Create: [
			{Id: tailordb.#Everyone, Permit: tailordb.#Permit.Allow},
		]
		Read: [
			{Id: tailordb.#Everyone, Permit: tailordb.#Permit.Allow},
		]
		Update: [
			{Id: tailordb.#Everyone, Permit: tailordb.#Permit.Allow},
		]
		Delete: [
			{Id: tailordb.#Everyone, Permit: tailordb.#Permit.Allow},
		]
		Admin: [
			{Id: tailordb.#Everyone, Permit: tailordb.#Permit.Allow},
		]
	}
}
