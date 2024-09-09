package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/master"
	"tailor.build/template/environment"
)

tailordb.#Spec & {
	Namespace: environment.#app.namespace
	Types: [
		for model in master {
			model
		},
	]
}
