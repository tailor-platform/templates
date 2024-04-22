package v2

import (
	"github.com/tailor-platform/tailorctl/schema/v2"
	"tailor.build/template/manifest/application"
	"tailor.build/template/manifest/services/tailordb"
	"tailor.build/template/manifest/services/pipeline"
	"tailor.build/template/manifest/services/stateflow"
	"tailor.build/template/manifest/services/auth"
)

v2.#Workspace & {
	Apps: [
		application
	]
	Services: [tailordb, pipeline, stateflow, auth]
}
