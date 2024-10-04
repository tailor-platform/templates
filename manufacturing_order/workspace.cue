package v2

import (
	"github.com/tailor-platform/tailorctl/schema/v2"
	"tailor.build/template/application"
	"tailor.build/template/services/tailordb"
	"tailor.build/template/services/pipeline"
	"tailor.build/template/services/auth"
	"tailor.build/template/services/executor"
)

v2.#Workspace & {
	Apps: [
		application,
	]
	Services: [tailordb, pipeline, auth, executor]
}
