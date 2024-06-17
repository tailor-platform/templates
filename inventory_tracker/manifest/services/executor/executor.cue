package executor

import (
	"github.com/tailor-platform/tailorctl/schema/v2/executor"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/environment"
	"github.com/tailor-platform/tailorctl/schema/v2/secretmanager"
	"tailor.build/template/manifest/services/pipeline:settings"
)

executor.#Spec & {
	Executors: [
		#eventBasedExecutor,
		#incomingWebhookBasedExecutor,
		// #scheduledEventBasedExecutor,
		#pushItemToShopify,
		#slackNotification,
	]
}

#eventBasedExecutor: executor.#Executor & {
	Name:        "eventbased-executor"
	Description: "Create a data based on the event"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.created"
		Condition: common.#Script & {
			Expr: """
				args.NamespaceName == "\(environment.#app.namespace)" && args.TypeName == "PurchaseOrder"
				"""
		}
	}
	Target: executor.#TargetTailorGraphql & {
		AppName: environment.#app.namespace
		Query: """
		mutation ($input: createPutAwayWithEventInput!) {
			createPutAwayWithEvent(input: $input)
		}"""
		Variables: common.#Script & {
			Expr: """
			({
				"input": {
					"quantity": args.data.newRecord.quantity,
					"purchaseOrderID": args.data.newRecord.id,
					"putAwayDate": args.data.newRecord.purchaseOrderDate
				}
			})"""
		}
	}
}

#incomingWebhookBasedExecutor: executor.#Executor & {
	Name:    "incomingwebhook-executor"
	Trigger: executor.#TriggerIncomingWebhook
	Target: executor.#TargetTailorGraphql & {
		AppName: environment.#app.namespace
		Invoker: settings.adminInvoker
		Query: """
			mutation createProduct($name: String!) {
				createProduct(input: { name: $name }) {
					id
				}
			}"""
		Variables: common.#Script & {
			Expr: """
			({
				"name": args.data.title,
			})"""
		}
	}
}

#scheduledEventBasedExecutor: executor.#Executor & {
	Name:        "scheduled-executor"
	Description: "description"
	Trigger: executor.#TriggerSchedule & {
		Timezone:  "UTC"
		Frequency: "0 0 1 * *"
	}
	Target: executor.#TargetWebhook & {
		URL: common.#Script & {
			Expr: "\"https://sample.api.mockbin.io/\""
		}
		Body: common.#Script & {
			Expr: """
			({
				"timestamp": new Date().toISOString()
			})"""
		}
	}
}



#pushItemToShopify: executor.#Executor & {
	Name:        "push-item-to-shopify"
	Description: "Push item to Shopify"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.created"
		Condition: common.#Script & {
			Expr: """
				args.NamespaceName == "\(environment.#app.namespace)" && args.TypeName == "Product"
				"""
		}
	}
	Target: executor.#TargetWebhook & {
		URL: common.#Script & {
			Expr: "\"https://{your_store_id}.myshopify.com/admin/api/2024-01/products.json\""
		}
		Headers: [
			{
				Key:   "X-Shopify-Access-Token"
				Value: secretmanager.#SecretValue & {
					VaultName: "vault"
					SecretKey: "token"
				}
			}
		]
		Body: common.#Script & {
			Expr: """
			({
				"product": {
					"title": args.data.newRecord.name
				}
			})"""
		}
	}
}

#slackNotification: executor.#Executor & {
	Name:        "slacknotification"
	Description: "notify slack when new product is created"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.created"
		Condition: common.#Script & {
			Expr: """
				args.NamespaceName == "\(environment.#app.namespace)" && args.TypeName == "Product"
				"""
		}
	}
	Target: executor.#TargetWebhook & {
		URL: common.#Script & {
			Expr: "\"https://hooks.slack.com/services/{your_webhook_endpoint}/\""
		}
		Headers: [
			{
				Key:   "Content-type"
				Value: "application/json"
			}
		]
		Body: common.#Script & {
			Expr: """
			({
				"text": "New Product Registration :tada:",
				"blocks": [
					{
						"type": "section",
						"text": {
							"type": "mrkdwn",
							"text": "*New Product Registration* :tada: " + args.data.newRecord.name
						}
					}
				]
			})"""
		}
	}
}


