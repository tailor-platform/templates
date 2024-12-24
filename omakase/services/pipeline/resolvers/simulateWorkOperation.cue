package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

simulateWorkOperationOutput: {
	Name: "simulateWorkOperationOutput"
	Fields: [
		{Name: "outputQuantity", Type: pipeline.Float, Required: true},
		{
			Name:  "result"
			Array: true
			Type: {
				Name: "listPickingOperationResult"
				Fields: [
					{Name: "id", Type: pipeline.ID},
					{Name: "duration", Type: pipeline.Float},
					{Name: "order", Type: pipeline.Int},
					{Name: "calculatedDuration", Type: pipeline.Float},
					{Name: "documentUrl", Type: pipeline.String},
					{Name: "description", Type: pipeline.String},
					{Name: "name", Type: pipeline.String},
					{Name: "isActive", Type: pipeline.Boolean},
					{Name: "workCenterId", Type: pipeline.ID},
					{Name: "workCenter", Type: pipeline.String},
				]
			}
		},
	]
}

simulateWorkOperation: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "simulateWorkOperation"
	Description:   "Simulate the work Operation required for given bill of material"
	Response: {Type: simulateWorkOperationOutput}
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "simulateWorkOperationInput"
				Fields: [
					{Name: "bomId", Type: pipeline.ID, Required: true},
					{Name: "outputQuantity", Type: pipeline.Float, Required: true},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "fetchOperations"
			Description: "Fetch all Operations"
			PreScript: """
					{
						'bomId': context.args.input.bomId
					}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
						query fetchOperations($bomId: ID!) {
							operations(
								query: {bomId: {eq:$bomId}, isActive: {eq: true}}
							) {
								edges {
      								node {
										id
										duration
										workCenterId
										documentUrl
										description
										name
										order
										isActive
										workCenter {
											name
											timeEfficiency
											parallelProcessingLimit
											setupTime
											cleanupTime
										}
									}
								}
							}
						}"""
			}
			PostHook: common.#Script & {
				Expr: """
					(() => {
						const operations = args.operations;
						const outputQuantity = context.args.input.outputQuantity;
						const result = args.operations.edges.length == 0 ? [] : args.operations.edges.map(e=> ({
							"id": e.node.id,
							"duration": e.node.duration,
							"order": e.node.order,
							"documentUrl": e.node.documentUrl,
							"description": e.node.description,
							"name": e.node.name,
							"isActive": e.node.isActive,
							"workCenterId": e.node.workCenterId,
							"workCenter": e.node.workCenter.name,
							"calculatedDuration": Math.floor(e.node.workCenter.setupTime + e.node.workCenter.cleanupTime + ((Math.floor(outputQuantity / e.node.workCenter.parallelProcessingLimit) + (outputQuantity % e.node.workCenter.parallelProcessingLimit)) * e.node.duration * 100 / (e.node.workCenter.timeEfficiency * 100)))
						}));

						return {
							operations,
							outputQuantity,
							result
						}
					})()
				"""
			}
			PostValidation: """
					size(context.pipeline.fetchOperations.operations.edges) == 0 ?
					['No operations found for ',context.args.input.bomId].join(''):
					''
				"""
		},
	]
}
