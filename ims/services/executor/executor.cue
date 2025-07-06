package executor

import (
	"github.com/tailor-platform/tailorctl/schema/v2/executor"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/services/pipeline:settings"
)

executor.#Spec & {
	Executors: [
		#triggerTestPayload,
	]
}

#triggerTestPayload: executor.#Executor & {
	Name:    "incomingwebhook-executor"
	Trigger: executor.#TriggerIncomingWebhook
	Target: executor.#TargetTailorGraphql & {
		AppName: "ims"
		Invoker: settings.adminInvoker
		Query: """
			mutation createProduct($title: String!) {
				createProduct(input: { title: $title }) {
					id
				}
			}"""
		Variables: common.#Script & {
			Expr: """
			({
				"title": args.body.title,
			})"""
		}
	}
}
