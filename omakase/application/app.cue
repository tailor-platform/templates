package application

import (
	"github.com/tailor-platform/tailorctl/schema/v2/application"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/services/auth"
	"tailor.build/template/services/tailordb"
	"tailor.build/template/services/pipeline"
	"tailor.build/template/environment"
)

application.#Spec & {
	Name: environment.#app.namespace
	Cors: [
		"http://localhost:8080",
		"http://localhost:8081",
		"http://localhost:3000",
		"https://*-www.dev.tailor.tech",
    "https://*.dev.tailor.tech",
    "https://*.tailor.tech",
    "https://www.tailor.tech",
		"https://tailor-omakase-*.vercel.app"
	]
	Auth: application.#Auth & {
		Namespace:            auth.Namespace
		IdProviderConfigName: auth.IdProviderConfigs[0].Name
	}
	Subgraphs: [
		{Type: common.#TailorDB, Name: tailordb.Namespace},
		{Type: common.#Pipeline, Name: pipeline.Namespace},
	]
}
