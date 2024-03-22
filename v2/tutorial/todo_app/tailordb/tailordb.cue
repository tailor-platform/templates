package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"github.com/tailor-platform/templates/tutorial/todo_app/tailordb/types"
)

tailordb.#Spec & {
	Namespace: "galaxy"
	Types: [
		{types.Task},
	]
}
