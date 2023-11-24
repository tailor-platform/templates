package pipeline

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

gatewayUrl: {{ .Values.gateway.graphqlEndpoint | quote }}

OnboardNewUserInput: {
	name: "OnboardNewUserInput"
	fields: [
		{ name: "username",    type: schema.String, required: true },
		{ name: "displayName", type: schema.String, required: true },
		{ name: "secret",      type: schema.String, required: true },
	]
}

OnboardNewUserOutput: {
	name: "OnboardNewUserOutput"
	fields: [
		{ name: "taskID",          type: schema.ID },
		{ name: "title",           type: schema.String },
		{ name: "priority",        type: schema.Int },
		{ name: "assignedUserID",  type: schema.ID  },
	]
}

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindPipeline
	spec:    manifest.#SpecPipeline & {
		namespace: pipelinev1.#Namespace & {
			name: {{ .Values.pipeline.namespace | quote }}
		}
		manifest: pipelinev1.#Manifests & {
			namespace: {{ .Values.pipeline.namespace | quote }}
			description: "Task mgmt app pipelines"
			resolverMap: {
				onboardNewUser: pipelinev1.#Resolver & {
					authorization: "true"
					id: {{ generateUUID | quote }} @ignoreChange()
					name:        "onboardNewUser"
					description: "Creates a user and assign them an initial task"
					inputs: [
						{ name: "input", type:OnboardNewUserInput },
						]
					response: { type: OnboardNewUserOutput }
					pipeline: [
						{
							id: {{ generateUUID | quote }} @ignoreChange()
							name:        "createsUser"
							description: "Creates a user"
							url:         gatewayUrl
							preScript:   """
							{
								"input": context.args.input
							}
							"""
							graphqlQuery: """
								mutation($input: CreateUserInput!) {
									createUser(input: $input) {
										id
									}
								}
							"""
							postScript: "args.createUser"
						},
						{
							id: {{ generateUUID | quote }} @ignoreChange()
							name:        "createsTask"
							description: "Creates a task and assigns it to the created user"
							url:         gatewayUrl
							preScript: """
								{
									"title": "Welcome! First of all, try out the coffee machine.",
									"priority": 1,
									"assignedUserID": args.id
								}
							"""
							graphqlQuery: """
								mutation($title: String, $priority: Int, $assignedUserID: ID) {
									createTask(input: { title: $title, priority: $priority, assignedUserID: $assignedUserID }) {
										taskID:id
										title
										priority
										assignedUserID
									}
								}
							"""
							postScript: "args.createTask"
						},
					]
				}
			}
		}
	}
}
