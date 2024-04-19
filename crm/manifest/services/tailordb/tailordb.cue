package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb/master"
	"tailor.build/template/environment"
)

tailordb.#Spec & {
	Namespace: environment.#app.namespace,
	Types: [
		{master.CustomerAccount},
		{master.Engagement},
		{master.Lead},
		{master.Role},
		{master.Transaction},
		{master.User},
	]
}
