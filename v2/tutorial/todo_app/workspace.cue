package v2

import (
	"github.com/tailor-platform/tailorctl/schema/v2"
	"github.com/tailor-platform/templates/tutorial/todo_app/applications"
	"github.com/tailor-platform/templates/tutorial/todo_app/tailordb"
)

v2.#Workspace & {
	Apps: [
		applications,
	]
	Services: [tailordb]
}
