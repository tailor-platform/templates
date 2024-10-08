package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/master"
	"tailor.build/template/services/tailordb/bom"
	"tailor.build/template/services/tailordb/workOrder"
	"tailor.build/template/environment"
)

tailordb.#Spec & {
	Namespace: environment.#app.namespace
	Types: [
		for model in master {
			model
		},
		for model in bom {
			model
		},
		for model in workOrder {
			model
		},
	]
}
