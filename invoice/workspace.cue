package v2

import (
	"github.com/tailor-platform/tailorctl/schema/v2"
	"tailor.build/template/application"
	"tailor.build/template/services/tailordb"
	"tailor.build/template/services/pipeline"
	"tailor.build/template/services/stateflow"
	"tailor.build/template/services/auth"
)

v2.#Workspace & {
	Apps: [
		application,
	]
	Services: [tailordb, pipeline, stateflow, auth]
}
