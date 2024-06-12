package v2

import (
	"github.com/tailor-platform/tailorctl/schema/v2"
	"tailor.build/template/manifest/application"
	"tailor.build/template/manifest/services/tailordb"
	"tailor.build/template/manifest/services/pipeline"
	"tailor.build/template/manifest/services/auth"
	"tailor.build/template/manifest/services/executor"
)

v2.#Workspace & {
	Apps: [
		application
	]
	Services: [
		tailordb,
		pipeline,
		auth,
		executor
	]
}
