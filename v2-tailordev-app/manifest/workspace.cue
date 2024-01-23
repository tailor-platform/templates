package config

import (
	"github.com/tailor-platform/tailorctl/schema/v2"
	"github.com/tailor-platform/tailorctl/schema/v2/application"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"github.com/tailor-inc/platform-core-services/e2e/manifest"
	"github.com/tailor-inc/platform-core-services/e2e/manifest/services/tailordb"
	"github.com/tailor-inc/platform-core-services/e2e/manifest/services/pipeline"
	"github.com/tailor-inc/platform-core-services/e2e/manifest/services/stateflow"
)

v2.#Workspace & {
	apps: [
		application.#Spec & {
			name: manifest.#appname
			cors: [
				"http://localhost:8080",
				"http://localhost:8081",
			]
			subgraphs: [
				{type: common.#TailorDB, name:  tailordb.namespace},
				{type: common.#Pipeline, name:  pipeline.namespace},
				{type: common.#Stateflow, name: stateflow.namespace},
			]
		},
	]
	services: [tailordb, pipeline, stateflow]
}
