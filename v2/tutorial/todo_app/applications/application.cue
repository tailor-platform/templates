package applications

import (
	"github.com/tailor-platform/tailorctl/schema/v2/application"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"github.com/tailor-platform/templates/tutorial/todo_app/tailordb"
)

application.#Spec & {
	Name: "todo-app"
	Cors: [
		"https://*.tailor.business",
		"http://localhost:3000",
		"https://*.vercel.app",
		"https://*.tailor-console.pages.dev",
		"https://console.tailor.tech",
	]
	Subgraphs: [
		{Type: common.#TailorDB, Name: tailordb.Namespace},
	]
}
