package pipelines

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
	"{{ .Values.cue.package }}/charts/pipeline/resolvers"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   {{ .Values.pipeline.namespace | quote }}
	invoker:     directories.roleMap.Admin.id
	description: "Invoice pipeline resolver"
	sdl: """
		input reviewInvoiceInput {
			invoiceCode: Int
			invoiceName: String!
			quote: Int!
		}
		type reviewInvoiceResult {
			id: ID
			stateID: ID
		}
		input approveInvoiceInput {
			stateID: ID!
			invoiceID: ID!
		}

		type approveInvoiceResult {
			success: Boolean
			state: reviewState
		}

		type reviewState {
			currentState: String
		}

		type Mutation {
			reviewInvoice(input: reviewInvoiceInput): reviewInvoiceResult
			approveInvoice(input: approveInvoiceInput): approveInvoiceResult
		}
		"""
	resolverMap: {
		"reviewInvoice":  resolvers.reviewInvoice
		"approveInvoice": resolvers.approveInvoice
	}
}
